/* csim.c
 * Cache simulator that employs the use of an array of sets, each containing an
 * LRU queue as well as an array of entries that serve as blocks.
 * @author Jason Hoang
 * @andrew jvhoang
 *
 */
#include "cachelab.h"
#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
/*
 * typedef structs for the queue
 */
/**
 * @brief Linked list element containing a string.
 *
 */
typedef struct list_ele {
    /**
     * @brief Pointer to a char array containing a string value.
     *
     * The memory for this string should be explicitly allocated and freed
     * whenever an element is inserted and removed from the queue.
     */
    long value;

    /**
     * @brief Pointer to the next element in the linked list.
     */
    struct list_ele *next;
} list_ele_t;

/**
 * @brief Queue structure representing a list of elements
 */
typedef struct {
    /**
     * @brief Pointer to the first element in the queue, or NULL if the
     *        queue is empty.
     */
    list_ele_t *head;
    list_ele_t *tail;
    int size;
} queue_t;
/*
 * typedef structs for the cache
 */
typedef struct {
    int valid;
    int dirtyBit;
    unsigned long tag;
} entry; // represents each entry in a set

typedef struct {
    queue_t *LRU;
    entry *entries;
} set; // represents each set in the cache

typedef struct {
    char operation;
    unsigned long address;
    long *tag;
    long setNumber;
    long size;
} traceLine; // to track the inputs

typedef set *cache; // array of sets

// returns a^b in int form, used to make cache calculations
unsigned int powfunc(unsigned int a, unsigned int b) {
    unsigned int ans = 1;
    unsigned int x = b;
    while (x > 0) {
        ans = ans * a;
        x--;
    }
    return ans;
}

// Prints out messages for the -h flag
void printUsageInfo() {
    printf("Usage: ./csim-ref [-hv] -s <s> -E <E> -b <b> -t <tracefile>");
    printf("\n");
    // printf("-h: Optional help flag that prints usage info");
    // printf("\n");
    // printf("-v: Optional verbose flag that displays trace info");
    // printf("\n");
    // printf("-s <s>: Number of set index bits (S = 2^s is the number of
    // sets)"); printf("\n"); printf("-E <E>: Associativity (number of lines per
    // set)"); printf("\n"); printf("-b <b>: Number of block bits (B = 2^b is
    // the block size)"); printf("\n"); printf("-t <tracefile>: Name of the
    // memory trace to replay"); printf("\n");
}
/**
 * @brief Allocates a new queue
 * @return The new queue, or NULL if memory allocation failed
 */
queue_t *queue_new(void) {
    queue_t *q = malloc(sizeof(queue_t));
    if (q == NULL) {
        return NULL;
    }
    q->head = NULL;
    q->tail = NULL;
    q->size = 0;
    return q;
}

/**
 * @brief Frees all memory used by a queue
 * @param[in] q The queue to free
 */
void queue_free(queue_t *q) {
    if (q != NULL) {
        list_ele_t *currElem = q->head;
        while (currElem != NULL) {
            list_ele_t *temp = currElem->next;
            free(currElem);
            currElem = temp;
        }
        free(q);
    }
}

/**
 * @brief Attempts to insert an element at tail of a queue
 *
 * @param[in] q The queue to insert into
 * @param[in] s long value to be assigned
 *
 * @return true if insertion was successful
 * @return false if q is NULL, or memory allocation failed
 */
bool queue_insert_tail(queue_t *q, long s) {
    list_ele_t *newt;
    if (q == NULL) {
        return false;
    }
    newt = malloc(sizeof(list_ele_t));
    if (q->head == NULL) {
        q->head = newt;
        q->tail = newt;
    } else {
        q->tail->next = newt;
        q->tail = newt;
    }
    newt->next = NULL;
    newt->value = s;
    q->size = q->size + 1;
    return true;
}

int findMin(int one, int two) {
    if (one > two) {
        return two;
    } else {
        return one;
    }
}
/**
 * @brief Attempts to remove an element from head of a queue
 *
 * If removal succeeds, this function frees all memory used by the
 * removed list element and its string value before returning.
 *
 * If removal succeeds and `buf` is non-NULL, this function copies up to
 * `bufsize - 1` characters from the removed string into `buf`, and writes
 * a null terminator '\0' after the copied string.
 *
 * @param[in]  q       The queue to remove from
 *
 * @return the value of the removed element
 */
long queue_remove_head(queue_t *q) {

    if (q == NULL || q->head == NULL) {
        return 9999999;
    }
    list_ele_t *temp = q->head;
    if (q->tail == q->head) {
        q->tail = NULL;
    }
    q->head = q->head->next;
    long ans = temp->value;
    q->size = q->size - 1;
    free(temp);
    return ans;
}
/*
 * Removes the first element in the queue with the passed in value
 */

void removeElement(queue_t *q, long s) {
    if (q->head->value == s) {
        queue_remove_head(q);
        return;
    }
    list_ele_t *currNode = q->head;
    list_ele_t *prevNode = NULL;
    while (currNode->value != s) {

        if (currNode->next == NULL) {
            return;
        } else {
            prevNode = currNode;
            currNode = currNode->next;
        }
    }
    if (currNode == q->tail) {
        q->tail = prevNode;
    }
    prevNode->next = currNode->next;
    free(currNode);
}
// /*
// * Prints the contents of the q
// */
// void printQ(queue_t *q) {
//     list_ele_t *curr = q->head;
//     if (curr == NULL) {
//         return;
//     }
//     while (curr->next != NULL) {
//         printf("%lu", curr->value);
//         printf("  ");
//         fflush(stdout);
//         curr = curr->next;
//     }
//     printf("%lu", curr->value);
//     printf("  ");
// }

/*
 * Initializes the LRU by adding the number of ways to the queue
 */
void initializeLRU(queue_t *q, unsigned long associativity) {
    for (unsigned int i = 0; i < associativity; i++) {
        queue_insert_tail(q, i);
    }
}

/*
 * Initializes the cache by allocating entries for each set
 */
cache initializeCache(cache cacheInput, unsigned int numSets,
                      unsigned long associativity) {
    queue_t *temp;
    cache answer;
    answer = cacheInput;
    for (unsigned int i = 0; i < numSets; i++) {
        temp = queue_new();
        set *currentSet = &answer[i];
        currentSet->LRU = temp;
        initializeLRU(currentSet->LRU, associativity);
        entry *Entries = calloc(associativity, sizeof(entry));
        currentSet->entries = Entries;
        for (unsigned int j = 0; j < associativity; j++) {
            currentSet->entries[j].valid = 0;
            currentSet->entries[j].dirtyBit = 0;
            currentSet->entries[j].tag = 0;
        }
    }
    return answer;
}
/*
 * Updates the cache given arguments from a trace line
 */
void updateCache(unsigned long address, unsigned long setBits,
                 unsigned long offsetBits, unsigned long associativity,
                 cache cacheInput, csim_stats_t *csimStatst, int LOrS,
                 bool vFlag) {

    queue_t *LRU;
    entry currEntry;
    unsigned long setNumber;
    unsigned long numTagBits = 64 - setBits - offsetBits;
    unsigned long tag = address >> (setBits + offsetBits);

    if (numTagBits != 64) {
        setNumber = (address << numTagBits) >> (numTagBits + offsetBits);
    } else {
        setNumber = 0;
    }
    set *currSet = &cacheInput[setNumber];
    LRU = currSet->LRU;
    unsigned long dirtyBs = 1 << offsetBits;

    /* Look for a hit in every entry*/
    for (unsigned int i = 0; i < associativity; i++) {
        if (currSet == NULL) {
            printf("NULLSET!");
        }
        if (currSet->entries == NULL) {
            printf("NULLENTRY!");
        }
        currEntry = currSet->entries[i];

        if (currEntry.valid == 1) {
            if (currEntry.tag == tag) {
                csimStatst->hits++;
                if (vFlag)
                    printf("hit\n");
                if ((LOrS == 0) && (currEntry.dirtyBit == 0)) {
                    csimStatst->dirty_bytes += dirtyBs;
                    currSet->entries[i].dirtyBit = 1;
                }
                removeElement(LRU, i);
                queue_insert_tail(LRU, i);
                return;
            }
        }
    }
    /* Miss*/
    csimStatst->misses++;

    long position = queue_remove_head(LRU);
    queue_insert_tail(LRU, position);
    /* Never previously filled, miss no eviction*/
    if (currSet->entries[position].valid == 0) {
        currSet->entries[position].valid = 1;
        if (vFlag)
            printf("miss \n");
        if (LOrS == 0) {
            currSet->entries[position].dirtyBit = 1;
            csimStatst->dirty_bytes += dirtyBs;
        }
    }
    /* Previously Filled, looked to evict*/
    else {
        if (currSet->entries[position].dirtyBit == 1) {
            csimStatst->dirty_evictions += dirtyBs;
            csimStatst->dirty_bytes -= dirtyBs;
        }
        if (LOrS == 0) {
            csimStatst->dirty_bytes += dirtyBs;
            currSet->entries[position].dirtyBit = 1;
        } else {
            currSet->entries[position].dirtyBit = 0;
        }
        csimStatst->evictions++;
        if (vFlag)
            printf("eviction \n");
    }
    currSet->entries[position].tag = tag;
    if (currSet->entries == NULL) {
        printf("NULLENTRY2!");
        fflush(stdout);
    }
    return;
}
/*
 * Frees all the created structures used in the cache
 */
void freeAllocs(csim_stats_t *temp, cache cachey, unsigned long numSets,
                unsigned long associativity) {
    free(temp);
    for (unsigned int i = 0; i < numSets; i++) {
        free(cachey[i].entries);
        queue_free(cachey[i].LRU);
    }
    free(cachey);
}
/*
 * Simulates the cache
 */
int main(int argc, char *argv[]) {
    int inputs;
    unsigned int setBits, offsetBits;
    unsigned long associativity;
    unsigned int blockSize, numSets, cacheSize;
    bool hflag, vflag, isValidTrace;
    char *trace;
    FILE *openTrace;
    traceLine tLine;
    while ((inputs = getopt(argc, argv, "hvs:E:b:t:")) != -1) {
        switch (inputs) {
        case 'h':
            hflag = true;
            break;
        case 'v':
            vflag = true;
            break;
        case 's':
            setBits = (unsigned int)atoi(optarg);
            printf("SetBits:");
            printf("%d", setBits);
            printf("\n");
            break;
        case 'E':
            associativity = (unsigned long)atoi(optarg);
            printf("Associativity:");
            printf("%lu", associativity);
            printf("\n");
            break;
        case 'b':
            offsetBits = (unsigned int)atoi(optarg);
            printf("OffsetBits:");
            printf("%d", offsetBits);
            printf("\n");
            break;
        case 't':
            isValidTrace = true;
            trace = optarg;
            break;
        default:
            break;
        }
    }

    if (setBits < 0 || associativity < 0 || associativity < 0 ||
        isValidTrace == false) {
        printf("Invalid Parameters \n");
        return 0;
    }
    if (hflag == true) {
        printUsageInfo();
    }

    blockSize = powfunc(2, offsetBits);
    numSets = powfunc(2, setBits);
    cacheSize = numSets * blockSize * (unsigned int)associativity;
    openTrace = fopen(trace, "rt");
    if (openTrace == NULL) {
        printf("File opening error: parse unsuccesful\n");
        fflush(stdout);
        exit(0);
    }
    /* allocate memory for my cache configuration*/
    cache workingCache = malloc((unsigned long)numSets * sizeof(set));
    if (workingCache == NULL) {
        return -1;
    }
    workingCache = initializeCache(workingCache, numSets, associativity);
    csim_stats_t *csimStatst = calloc(1, sizeof(csim_stats_t));
    while (fscanf(openTrace, "%c %lx,%lx\n", &tLine.operation, &tLine.address,
                  &tLine.size) > 0) {
        switch (tLine.operation) {
        case 'L':
            if (vflag) {
                printf("%c %lx,%lx ", tLine.operation, tLine.address,
                       tLine.size);
            }
            updateCache(tLine.address, setBits, offsetBits, associativity,
                        workingCache, csimStatst, 1, vflag);
            break;
        case 'S':
            if (vflag) {
                printf("%c %lx,%lx ", tLine.operation, tLine.address,
                       tLine.size);
            }
            updateCache(tLine.address, setBits, offsetBits, associativity,
                        workingCache, csimStatst, 0, vflag);
            break;
        default:
            printf("Invalid operation in trace file\n");
            return 1;
        }
    }
    printSummary(csimStatst);
    fclose(openTrace);
    freeAllocs(csimStatst, workingCache, numSets, associativity);
    return 0;
}
