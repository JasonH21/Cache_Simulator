; ModuleID = 'trans.c'
source_filename = "trans.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [21 x i8] c"Transpose submission\00", align 1
@.str.1 = private unnamed_addr constant [16 x i8] c"Basic transpose\00", align 1
@.str.2 = private unnamed_addr constant [36 x i8] c"Transpose using the temporary array\00", align 1

; Function Attrs: nounwind uwtable
define dso_local void @registerFunctions() local_unnamed_addr #0 !dbg !7 {
  tail call void @registerTransFunction(void (i64, i64, double*, double*, double*)* nonnull @transpose_submit, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str, i64 0, i64 0)) #3, !dbg !10
  tail call void @registerTransFunction(void (i64, i64, double*, double*, double*)* nonnull @trans_basic, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1, i64 0, i64 0)) #3, !dbg !11
  tail call void @registerTransFunction(void (i64, i64, double*, double*, double*)* nonnull @trans_tmp, i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.2, i64 0, i64 0)) #3, !dbg !12
  ret void, !dbg !13
}

declare dso_local void @registerTransFunction(void (i64, i64, double*, double*, double*)*, i8*) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define internal void @transpose_submit(i64, i64, double* nocapture readonly, double* nocapture, double* nocapture readnone) #0 !dbg !14 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !27, metadata !DIExpression()), !dbg !51
  call void @llvm.dbg.value(metadata i64 %1, metadata !28, metadata !DIExpression()), !dbg !52
  call void @llvm.dbg.value(metadata double* %2, metadata !29, metadata !DIExpression()), !dbg !53
  call void @llvm.dbg.value(metadata double* %3, metadata !30, metadata !DIExpression()), !dbg !54
  call void @llvm.dbg.value(metadata double* %4, metadata !31, metadata !DIExpression()), !dbg !55
  %6 = icmp eq i64 %0, %1, !dbg !56
  br i1 %6, label %29, label %7, !dbg !57

; <label>:7:                                      ; preds = %5
  call void @llvm.dbg.value(metadata i64 %0, metadata !58, metadata !DIExpression()), !dbg !71
  call void @llvm.dbg.value(metadata i64 %1, metadata !61, metadata !DIExpression()), !dbg !74
  call void @llvm.dbg.value(metadata double* %2, metadata !62, metadata !DIExpression()), !dbg !75
  call void @llvm.dbg.value(metadata double* %3, metadata !63, metadata !DIExpression()), !dbg !76
  call void @llvm.dbg.value(metadata double* %4, metadata !64, metadata !DIExpression()), !dbg !77
  call void @llvm.dbg.value(metadata i64 0, metadata !65, metadata !DIExpression()), !dbg !78
  %8 = icmp eq i64 %1, 0, !dbg !79
  %9 = icmp eq i64 %0, 0
  %10 = or i1 %9, %8, !dbg !80
  br i1 %10, label %92, label %11, !dbg !80

; <label>:11:                                     ; preds = %7, %26
  %12 = phi i64 [ %27, %26 ], [ 0, %7 ]
  call void @llvm.dbg.value(metadata i64 %12, metadata !65, metadata !DIExpression()), !dbg !78
  call void @llvm.dbg.value(metadata i64 0, metadata !67, metadata !DIExpression()), !dbg !81
  %13 = mul nsw i64 %12, %0
  %14 = getelementptr inbounds double, double* %2, i64 %13
  %15 = getelementptr inbounds double, double* %3, i64 %12
  br label %16, !dbg !82

; <label>:16:                                     ; preds = %16, %11
  %17 = phi i64 [ 0, %11 ], [ %24, %16 ]
  call void @llvm.dbg.value(metadata i64 %17, metadata !67, metadata !DIExpression()), !dbg !81
  %18 = getelementptr inbounds double, double* %14, i64 %17, !dbg !83
  %19 = bitcast double* %18 to i64*, !dbg !83
  %20 = load i64, i64* %19, align 8, !dbg !83, !tbaa !86
  %21 = mul nsw i64 %17, %1, !dbg !90
  %22 = getelementptr inbounds double, double* %15, i64 %21, !dbg !90
  %23 = bitcast double* %22 to i64*, !dbg !91
  store i64 %20, i64* %23, align 8, !dbg !91, !tbaa !86
  %24 = add nuw i64 %17, 1, !dbg !92
  call void @llvm.dbg.value(metadata i64 %24, metadata !67, metadata !DIExpression()), !dbg !81
  %25 = icmp eq i64 %24, %0, !dbg !93
  br i1 %25, label %26, label %16, !dbg !82, !llvm.loop !94

; <label>:26:                                     ; preds = %16
  %27 = add nuw i64 %12, 1, !dbg !97
  call void @llvm.dbg.value(metadata i64 %27, metadata !65, metadata !DIExpression()), !dbg !78
  %28 = icmp eq i64 %27, %1, !dbg !79
  br i1 %28, label %92, label %11, !dbg !80, !llvm.loop !98

; <label>:29:                                     ; preds = %5
  switch i64 %0, label %74 [
    i64 32, label %30
    i64 1024, label %92
    i64 0, label %92
  ], !dbg !101

; <label>:30:                                     ; preds = %29, %72
  %31 = phi i64 [ %32, %72 ], [ 0, %29 ]
  call void @llvm.dbg.value(metadata i64 %31, metadata !32, metadata !DIExpression()), !dbg !102
  call void @llvm.dbg.value(metadata i64 0, metadata !37, metadata !DIExpression()), !dbg !103
  %32 = add i64 %31, 8
  br label %33

; <label>:33:                                     ; preds = %36, %30
  %34 = phi i64 [ %35, %36 ], [ 0, %30 ]
  call void @llvm.dbg.value(metadata i64 %34, metadata !37, metadata !DIExpression()), !dbg !103
  call void @llvm.dbg.value(metadata i64 %31, metadata !41, metadata !DIExpression()), !dbg !104
  %35 = add i64 %34, 8
  br label %38

; <label>:36:                                     ; preds = %43
  call void @llvm.dbg.value(metadata i64 %35, metadata !37, metadata !DIExpression()), !dbg !103
  %37 = icmp ult i64 %35, 32, !dbg !105
  br i1 %37, label %33, label %72, !dbg !106, !llvm.loop !107

; <label>:38:                                     ; preds = %33, %43
  %39 = phi i64 [ %44, %43 ], [ %31, %33 ]
  call void @llvm.dbg.value(metadata i64 %39, metadata !41, metadata !DIExpression()), !dbg !104
  call void @llvm.dbg.value(metadata i64 %34, metadata !45, metadata !DIExpression()), !dbg !109
  %40 = shl nsw i64 %39, 5
  %41 = getelementptr inbounds double, double* %2, i64 %40
  %42 = getelementptr inbounds double, double* %3, i64 %39
  br label %51, !dbg !110

; <label>:43:                                     ; preds = %69
  %44 = add nuw i64 %39, 1, !dbg !111
  call void @llvm.dbg.value(metadata i64 %44, metadata !41, metadata !DIExpression()), !dbg !104
  %45 = icmp ult i64 %44, %32, !dbg !112
  br i1 %45, label %38, label %36, !dbg !113, !llvm.loop !114

; <label>:46:                                     ; preds = %61
  call void @llvm.dbg.value(metadata i64 %34, metadata !49, metadata !DIExpression()), !dbg !116
  %47 = getelementptr inbounds double, double* %41, i64 %39
  %48 = bitcast double* %47 to i64*
  %49 = getelementptr inbounds double, double* %42, i64 %40
  %50 = bitcast double* %49 to i64*
  br label %64, !dbg !117

; <label>:51:                                     ; preds = %61, %38
  %52 = phi i64 [ %34, %38 ], [ %62, %61 ]
  call void @llvm.dbg.value(metadata i64 %52, metadata !45, metadata !DIExpression()), !dbg !109
  %53 = icmp eq i64 %39, %52, !dbg !118
  br i1 %53, label %61, label %54, !dbg !122

; <label>:54:                                     ; preds = %51
  %55 = getelementptr inbounds double, double* %41, i64 %52, !dbg !123
  %56 = bitcast double* %55 to i64*, !dbg !123
  %57 = load i64, i64* %56, align 8, !dbg !123, !tbaa !86
  %58 = shl nsw i64 %52, 5, !dbg !125
  %59 = getelementptr inbounds double, double* %42, i64 %58, !dbg !125
  %60 = bitcast double* %59 to i64*, !dbg !126
  store i64 %57, i64* %60, align 8, !dbg !126, !tbaa !86
  br label %61, !dbg !127

; <label>:61:                                     ; preds = %54, %51
  %62 = add nuw i64 %52, 1, !dbg !128
  call void @llvm.dbg.value(metadata i64 %62, metadata !45, metadata !DIExpression()), !dbg !109
  %63 = icmp ult i64 %62, %35, !dbg !129
  br i1 %63, label %51, label %46, !dbg !110, !llvm.loop !130

; <label>:64:                                     ; preds = %69, %46
  %65 = phi i64 [ %34, %46 ], [ %70, %69 ]
  call void @llvm.dbg.value(metadata i64 %65, metadata !49, metadata !DIExpression()), !dbg !116
  %66 = icmp eq i64 %39, %65, !dbg !132
  br i1 %66, label %67, label %69, !dbg !136

; <label>:67:                                     ; preds = %64
  %68 = load i64, i64* %48, align 8, !dbg !137, !tbaa !86
  store i64 %68, i64* %50, align 8, !dbg !139, !tbaa !86
  br label %69, !dbg !140

; <label>:69:                                     ; preds = %67, %64
  %70 = add nuw i64 %65, 1, !dbg !141
  call void @llvm.dbg.value(metadata i64 %70, metadata !49, metadata !DIExpression()), !dbg !116
  %71 = icmp ult i64 %70, %35, !dbg !142
  br i1 %71, label %64, label %43, !dbg !117, !llvm.loop !143

; <label>:72:                                     ; preds = %36
  call void @llvm.dbg.value(metadata i64 %32, metadata !32, metadata !DIExpression()), !dbg !102
  %73 = icmp ult i64 %32, 32, !dbg !145
  br i1 %73, label %30, label %92, !dbg !146, !llvm.loop !147

; <label>:74:                                     ; preds = %29, %89
  %75 = phi i64 [ %90, %89 ], [ 0, %29 ]
  call void @llvm.dbg.value(metadata i64 %75, metadata !65, metadata !DIExpression()), !dbg !149
  call void @llvm.dbg.value(metadata i64 0, metadata !67, metadata !DIExpression()), !dbg !153
  %76 = mul nsw i64 %75, %0
  %77 = getelementptr inbounds double, double* %2, i64 %76
  %78 = getelementptr inbounds double, double* %3, i64 %75
  br label %79, !dbg !154

; <label>:79:                                     ; preds = %79, %74
  %80 = phi i64 [ 0, %74 ], [ %87, %79 ]
  call void @llvm.dbg.value(metadata i64 %80, metadata !67, metadata !DIExpression()), !dbg !153
  %81 = getelementptr inbounds double, double* %77, i64 %80, !dbg !155
  %82 = bitcast double* %81 to i64*, !dbg !155
  %83 = load i64, i64* %82, align 8, !dbg !155, !tbaa !86
  %84 = mul nsw i64 %80, %0, !dbg !156
  %85 = getelementptr inbounds double, double* %78, i64 %84, !dbg !156
  %86 = bitcast double* %85 to i64*, !dbg !157
  store i64 %83, i64* %86, align 8, !dbg !157, !tbaa !86
  %87 = add nuw i64 %80, 1, !dbg !158
  call void @llvm.dbg.value(metadata i64 %87, metadata !67, metadata !DIExpression()), !dbg !153
  %88 = icmp eq i64 %87, %0, !dbg !159
  br i1 %88, label %89, label %79, !dbg !154, !llvm.loop !94

; <label>:89:                                     ; preds = %79
  %90 = add nuw i64 %75, 1, !dbg !160
  call void @llvm.dbg.value(metadata i64 %90, metadata !65, metadata !DIExpression()), !dbg !149
  %91 = icmp eq i64 %90, %0, !dbg !161
  br i1 %91, label %92, label %74, !dbg !162, !llvm.loop !98

; <label>:92:                                     ; preds = %26, %72, %89, %29, %29, %7
  ret void, !dbg !163
}

; Function Attrs: nounwind uwtable
define internal void @trans_basic(i64, i64, double* nocapture readonly, double* nocapture, double* nocapture readnone) #0 !dbg !59 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !58, metadata !DIExpression()), !dbg !164
  call void @llvm.dbg.value(metadata i64 %1, metadata !61, metadata !DIExpression()), !dbg !165
  call void @llvm.dbg.value(metadata double* %2, metadata !62, metadata !DIExpression()), !dbg !166
  call void @llvm.dbg.value(metadata double* %3, metadata !63, metadata !DIExpression()), !dbg !167
  call void @llvm.dbg.value(metadata double* %4, metadata !64, metadata !DIExpression()), !dbg !168
  call void @llvm.dbg.value(metadata i64 0, metadata !65, metadata !DIExpression()), !dbg !169
  %6 = icmp eq i64 %1, 0, !dbg !170
  %7 = icmp eq i64 %0, 0
  %8 = or i1 %6, %7, !dbg !99
  br i1 %8, label %27, label %9, !dbg !99

; <label>:9:                                      ; preds = %5, %24
  %10 = phi i64 [ %25, %24 ], [ 0, %5 ]
  call void @llvm.dbg.value(metadata i64 %10, metadata !65, metadata !DIExpression()), !dbg !169
  call void @llvm.dbg.value(metadata i64 0, metadata !67, metadata !DIExpression()), !dbg !171
  %11 = mul nsw i64 %10, %0
  %12 = getelementptr inbounds double, double* %2, i64 %11
  %13 = getelementptr inbounds double, double* %3, i64 %10
  br label %14, !dbg !95

; <label>:14:                                     ; preds = %14, %9
  %15 = phi i64 [ 0, %9 ], [ %22, %14 ]
  call void @llvm.dbg.value(metadata i64 %15, metadata !67, metadata !DIExpression()), !dbg !171
  %16 = getelementptr inbounds double, double* %12, i64 %15, !dbg !172
  %17 = bitcast double* %16 to i64*, !dbg !172
  %18 = load i64, i64* %17, align 8, !dbg !172, !tbaa !86
  %19 = mul nsw i64 %15, %1, !dbg !173
  %20 = getelementptr inbounds double, double* %13, i64 %19, !dbg !173
  %21 = bitcast double* %20 to i64*, !dbg !174
  store i64 %18, i64* %21, align 8, !dbg !174, !tbaa !86
  %22 = add nuw i64 %15, 1, !dbg !175
  call void @llvm.dbg.value(metadata i64 %22, metadata !67, metadata !DIExpression()), !dbg !171
  %23 = icmp eq i64 %22, %0, !dbg !176
  br i1 %23, label %24, label %14, !dbg !95, !llvm.loop !94

; <label>:24:                                     ; preds = %14
  %25 = add nuw i64 %10, 1, !dbg !177
  call void @llvm.dbg.value(metadata i64 %25, metadata !65, metadata !DIExpression()), !dbg !169
  %26 = icmp eq i64 %25, %1, !dbg !170
  br i1 %26, label %27, label %9, !dbg !99, !llvm.loop !98

; <label>:27:                                     ; preds = %24, %5
  ret void, !dbg !178
}

; Function Attrs: nounwind uwtable
define internal void @trans_tmp(i64, i64, double* nocapture readonly, double* nocapture, double* nocapture) #0 !dbg !179 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !181, metadata !DIExpression()), !dbg !196
  call void @llvm.dbg.value(metadata i64 %1, metadata !182, metadata !DIExpression()), !dbg !197
  call void @llvm.dbg.value(metadata double* %2, metadata !183, metadata !DIExpression()), !dbg !198
  call void @llvm.dbg.value(metadata double* %3, metadata !184, metadata !DIExpression()), !dbg !199
  call void @llvm.dbg.value(metadata double* %4, metadata !185, metadata !DIExpression()), !dbg !200
  call void @llvm.dbg.value(metadata i64 0, metadata !186, metadata !DIExpression()), !dbg !201
  %6 = icmp eq i64 %1, 0, !dbg !202
  %7 = icmp eq i64 %0, 0
  %8 = or i1 %6, %7, !dbg !203
  br i1 %8, label %33, label %9, !dbg !203

; <label>:9:                                      ; preds = %5, %30
  %10 = phi i64 [ %31, %30 ], [ 0, %5 ]
  call void @llvm.dbg.value(metadata i64 %10, metadata !186, metadata !DIExpression()), !dbg !201
  call void @llvm.dbg.value(metadata i64 0, metadata !188, metadata !DIExpression()), !dbg !204
  %11 = mul nsw i64 %10, %0
  %12 = getelementptr inbounds double, double* %2, i64 %11
  %13 = shl i64 %10, 1
  %14 = and i64 %13, 2
  %15 = getelementptr inbounds double, double* %3, i64 %10
  br label %16, !dbg !205

; <label>:16:                                     ; preds = %16, %9
  %17 = phi i64 [ 0, %9 ], [ %28, %16 ]
  call void @llvm.dbg.value(metadata i64 %17, metadata !188, metadata !DIExpression()), !dbg !204
  call void @llvm.dbg.value(metadata i64 %10, metadata !192, metadata !DIExpression(DW_OP_constu, 1, DW_OP_and, DW_OP_stack_value)), !dbg !206
  %18 = and i64 %17, 1, !dbg !207
  call void @llvm.dbg.value(metadata i64 %18, metadata !195, metadata !DIExpression()), !dbg !208
  %19 = getelementptr inbounds double, double* %12, i64 %17, !dbg !209
  %20 = bitcast double* %19 to i64*, !dbg !209
  %21 = load i64, i64* %20, align 8, !dbg !209, !tbaa !86
  %22 = or i64 %18, %14, !dbg !210
  %23 = getelementptr inbounds double, double* %4, i64 %22, !dbg !211
  %24 = bitcast double* %23 to i64*, !dbg !212
  store i64 %21, i64* %24, align 8, !dbg !212, !tbaa !86
  %25 = mul nsw i64 %17, %1, !dbg !213
  %26 = getelementptr inbounds double, double* %15, i64 %25, !dbg !213
  %27 = bitcast double* %26 to i64*, !dbg !214
  store i64 %21, i64* %27, align 8, !dbg !214, !tbaa !86
  %28 = add nuw i64 %17, 1, !dbg !215
  call void @llvm.dbg.value(metadata i64 %28, metadata !188, metadata !DIExpression()), !dbg !204
  %29 = icmp eq i64 %28, %0, !dbg !216
  br i1 %29, label %30, label %16, !dbg !205, !llvm.loop !217

; <label>:30:                                     ; preds = %16
  %31 = add nuw i64 %10, 1, !dbg !219
  call void @llvm.dbg.value(metadata i64 %31, metadata !186, metadata !DIExpression()), !dbg !201
  %32 = icmp eq i64 %31, %1, !dbg !202
  br i1 %32, label %33, label %9, !dbg !203, !llvm.loop !220

; <label>:33:                                     ; preds = %30, %5
  ret void, !dbg !222
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 7.0.0 (tags/RELEASE_700/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "trans.c", directory: "/afs/andrew.cmu.edu/usr20/jvhoang/private/18213/cache-lab-JasonH21")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 7.0.0 (tags/RELEASE_700/final)"}
!7 = distinct !DISubprogram(name: "registerFunctions", scope: !1, file: !1, line: 160, type: !8, isLocal: false, isDefinition: true, scopeLine: 160, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null}
!10 = !DILocation(line: 162, column: 5, scope: !7)
!11 = !DILocation(line: 165, column: 5, scope: !7)
!12 = !DILocation(line: 166, column: 5, scope: !7)
!13 = !DILocation(line: 167, column: 1, scope: !7)
!14 = distinct !DISubprogram(name: "transpose_submit", scope: !1, file: !1, line: 125, type: !15, isLocal: true, isDefinition: true, scopeLine: 126, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !26)
!15 = !DISubroutineType(types: !16)
!16 = !{null, !17, !17, !20, !20, !25}
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !18, line: 62, baseType: !19)
!18 = !DIFile(filename: "/usr/local/depot/llvm-7.0/lib/clang/7.0.0/include/stddef.h", directory: "/afs/andrew.cmu.edu/usr20/jvhoang/private/18213/cache-lab-JasonH21")
!19 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, elements: !23)
!22 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!23 = !{!24}
!24 = !DISubrange(count: -1)
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!26 = !{!27, !28, !29, !30, !31, !32, !37, !41, !45, !49}
!27 = !DILocalVariable(name: "M", arg: 1, scope: !14, file: !1, line: 125, type: !17)
!28 = !DILocalVariable(name: "N", arg: 2, scope: !14, file: !1, line: 125, type: !17)
!29 = !DILocalVariable(name: "A", arg: 3, scope: !14, file: !1, line: 125, type: !20)
!30 = !DILocalVariable(name: "B", arg: 4, scope: !14, file: !1, line: 125, type: !20)
!31 = !DILocalVariable(name: "tmp", arg: 5, scope: !14, file: !1, line: 126, type: !25)
!32 = !DILocalVariable(name: "i", scope: !33, file: !1, line: 130, type: !17)
!33 = distinct !DILexicalBlock(scope: !34, file: !1, line: 130, column: 9)
!34 = distinct !DILexicalBlock(scope: !35, file: !1, line: 129, column: 39)
!35 = distinct !DILexicalBlock(scope: !36, file: !1, line: 129, column: 16)
!36 = distinct !DILexicalBlock(scope: !14, file: !1, line: 127, column: 9)
!37 = !DILocalVariable(name: "j", scope: !38, file: !1, line: 131, type: !17)
!38 = distinct !DILexicalBlock(scope: !39, file: !1, line: 131, column: 13)
!39 = distinct !DILexicalBlock(scope: !40, file: !1, line: 130, column: 43)
!40 = distinct !DILexicalBlock(scope: !33, file: !1, line: 130, column: 9)
!41 = !DILocalVariable(name: "k", scope: !42, file: !1, line: 132, type: !17)
!42 = distinct !DILexicalBlock(scope: !43, file: !1, line: 132, column: 17)
!43 = distinct !DILexicalBlock(scope: !44, file: !1, line: 131, column: 47)
!44 = distinct !DILexicalBlock(scope: !38, file: !1, line: 131, column: 13)
!45 = !DILocalVariable(name: "l", scope: !46, file: !1, line: 133, type: !17)
!46 = distinct !DILexicalBlock(scope: !47, file: !1, line: 133, column: 21)
!47 = distinct !DILexicalBlock(scope: !48, file: !1, line: 132, column: 52)
!48 = distinct !DILexicalBlock(scope: !42, file: !1, line: 132, column: 17)
!49 = !DILocalVariable(name: "l", scope: !50, file: !1, line: 138, type: !17)
!50 = distinct !DILexicalBlock(scope: !47, file: !1, line: 138, column: 21)
!51 = !DILocation(line: 125, column: 37, scope: !14)
!52 = !DILocation(line: 125, column: 47, scope: !14)
!53 = !DILocation(line: 125, column: 57, scope: !14)
!54 = !DILocation(line: 125, column: 73, scope: !14)
!55 = !DILocation(line: 126, column: 37, scope: !14)
!56 = !DILocation(line: 127, column: 11, scope: !36)
!57 = !DILocation(line: 127, column: 9, scope: !14)
!58 = !DILocalVariable(name: "M", arg: 1, scope: !59, file: !1, line: 81, type: !17)
!59 = distinct !DISubprogram(name: "trans_basic", scope: !1, file: !1, line: 81, type: !15, isLocal: true, isDefinition: true, scopeLine: 82, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !60)
!60 = !{!58, !61, !62, !63, !64, !65, !67}
!61 = !DILocalVariable(name: "N", arg: 2, scope: !59, file: !1, line: 81, type: !17)
!62 = !DILocalVariable(name: "A", arg: 3, scope: !59, file: !1, line: 81, type: !20)
!63 = !DILocalVariable(name: "B", arg: 4, scope: !59, file: !1, line: 81, type: !20)
!64 = !DILocalVariable(name: "tmp", arg: 5, scope: !59, file: !1, line: 82, type: !25)
!65 = !DILocalVariable(name: "i", scope: !66, file: !1, line: 86, type: !17)
!66 = distinct !DILexicalBlock(scope: !59, file: !1, line: 86, column: 5)
!67 = !DILocalVariable(name: "j", scope: !68, file: !1, line: 87, type: !17)
!68 = distinct !DILexicalBlock(scope: !69, file: !1, line: 87, column: 9)
!69 = distinct !DILexicalBlock(scope: !70, file: !1, line: 86, column: 36)
!70 = distinct !DILexicalBlock(scope: !66, file: !1, line: 86, column: 5)
!71 = !DILocation(line: 81, column: 32, scope: !59, inlinedAt: !72)
!72 = distinct !DILocation(line: 128, column: 9, scope: !73)
!73 = distinct !DILexicalBlock(scope: !36, file: !1, line: 127, column: 17)
!74 = !DILocation(line: 81, column: 42, scope: !59, inlinedAt: !72)
!75 = !DILocation(line: 81, column: 52, scope: !59, inlinedAt: !72)
!76 = !DILocation(line: 81, column: 68, scope: !59, inlinedAt: !72)
!77 = !DILocation(line: 82, column: 32, scope: !59, inlinedAt: !72)
!78 = !DILocation(line: 86, column: 17, scope: !66, inlinedAt: !72)
!79 = !DILocation(line: 86, column: 26, scope: !70, inlinedAt: !72)
!80 = !DILocation(line: 86, column: 5, scope: !66, inlinedAt: !72)
!81 = !DILocation(line: 87, column: 21, scope: !68, inlinedAt: !72)
!82 = !DILocation(line: 87, column: 9, scope: !68, inlinedAt: !72)
!83 = !DILocation(line: 88, column: 23, scope: !84, inlinedAt: !72)
!84 = distinct !DILexicalBlock(scope: !85, file: !1, line: 87, column: 40)
!85 = distinct !DILexicalBlock(scope: !68, file: !1, line: 87, column: 9)
!86 = !{!87, !87, i64 0}
!87 = !{!"double", !88, i64 0}
!88 = !{!"omnipotent char", !89, i64 0}
!89 = !{!"Simple C/C++ TBAA"}
!90 = !DILocation(line: 88, column: 13, scope: !84, inlinedAt: !72)
!91 = !DILocation(line: 88, column: 21, scope: !84, inlinedAt: !72)
!92 = !DILocation(line: 87, column: 36, scope: !85, inlinedAt: !72)
!93 = !DILocation(line: 87, column: 30, scope: !85, inlinedAt: !72)
!94 = distinct !{!94, !95, !96}
!95 = !DILocation(line: 87, column: 9, scope: !68)
!96 = !DILocation(line: 89, column: 9, scope: !68)
!97 = !DILocation(line: 86, column: 32, scope: !70, inlinedAt: !72)
!98 = distinct !{!98, !99, !100}
!99 = !DILocation(line: 86, column: 5, scope: !66)
!100 = !DILocation(line: 90, column: 5, scope: !66)
!101 = !DILocation(line: 129, column: 25, scope: !35)
!102 = !DILocation(line: 130, column: 21, scope: !33)
!103 = !DILocation(line: 131, column: 25, scope: !38)
!104 = !DILocation(line: 132, column: 29, scope: !42)
!105 = !DILocation(line: 131, column: 34, scope: !44)
!106 = !DILocation(line: 131, column: 13, scope: !38)
!107 = distinct !{!107, !106, !108}
!108 = !DILocation(line: 144, column: 13, scope: !38)
!109 = !DILocation(line: 133, column: 33, scope: !46)
!110 = !DILocation(line: 133, column: 21, scope: !46)
!111 = !DILocation(line: 132, column: 48, scope: !48)
!112 = !DILocation(line: 132, column: 38, scope: !48)
!113 = !DILocation(line: 132, column: 17, scope: !42)
!114 = distinct !{!114, !113, !115}
!115 = !DILocation(line: 143, column: 17, scope: !42)
!116 = !DILocation(line: 138, column: 33, scope: !50)
!117 = !DILocation(line: 138, column: 21, scope: !50)
!118 = !DILocation(line: 134, column: 31, scope: !119)
!119 = distinct !DILexicalBlock(scope: !120, file: !1, line: 134, column: 29)
!120 = distinct !DILexicalBlock(scope: !121, file: !1, line: 133, column: 56)
!121 = distinct !DILexicalBlock(scope: !46, file: !1, line: 133, column: 21)
!122 = !DILocation(line: 134, column: 29, scope: !120)
!123 = !DILocation(line: 135, column: 39, scope: !124)
!124 = distinct !DILexicalBlock(scope: !119, file: !1, line: 134, column: 37)
!125 = !DILocation(line: 135, column: 29, scope: !124)
!126 = !DILocation(line: 135, column: 37, scope: !124)
!127 = !DILocation(line: 136, column: 25, scope: !124)
!128 = !DILocation(line: 133, column: 52, scope: !121)
!129 = !DILocation(line: 133, column: 42, scope: !121)
!130 = distinct !{!130, !110, !131}
!131 = !DILocation(line: 137, column: 21, scope: !46)
!132 = !DILocation(line: 139, column: 31, scope: !133)
!133 = distinct !DILexicalBlock(scope: !134, file: !1, line: 139, column: 29)
!134 = distinct !DILexicalBlock(scope: !135, file: !1, line: 138, column: 56)
!135 = distinct !DILexicalBlock(scope: !50, file: !1, line: 138, column: 21)
!136 = !DILocation(line: 139, column: 29, scope: !134)
!137 = !DILocation(line: 140, column: 39, scope: !138)
!138 = distinct !DILexicalBlock(scope: !133, file: !1, line: 139, column: 37)
!139 = !DILocation(line: 140, column: 37, scope: !138)
!140 = !DILocation(line: 141, column: 25, scope: !138)
!141 = !DILocation(line: 138, column: 52, scope: !135)
!142 = !DILocation(line: 138, column: 42, scope: !135)
!143 = distinct !{!143, !117, !144}
!144 = !DILocation(line: 142, column: 21, scope: !50)
!145 = !DILocation(line: 130, column: 30, scope: !40)
!146 = !DILocation(line: 130, column: 9, scope: !33)
!147 = distinct !{!147, !146, !148}
!148 = !DILocation(line: 145, column: 9, scope: !33)
!149 = !DILocation(line: 86, column: 17, scope: !66, inlinedAt: !150)
!150 = distinct !DILocation(line: 149, column: 9, scope: !151)
!151 = distinct !DILexicalBlock(scope: !152, file: !1, line: 148, column: 12)
!152 = distinct !DILexicalBlock(scope: !35, file: !1, line: 146, column: 16)
!153 = !DILocation(line: 87, column: 21, scope: !68, inlinedAt: !150)
!154 = !DILocation(line: 87, column: 9, scope: !68, inlinedAt: !150)
!155 = !DILocation(line: 88, column: 23, scope: !84, inlinedAt: !150)
!156 = !DILocation(line: 88, column: 13, scope: !84, inlinedAt: !150)
!157 = !DILocation(line: 88, column: 21, scope: !84, inlinedAt: !150)
!158 = !DILocation(line: 87, column: 36, scope: !85, inlinedAt: !150)
!159 = !DILocation(line: 87, column: 30, scope: !85, inlinedAt: !150)
!160 = !DILocation(line: 86, column: 32, scope: !70, inlinedAt: !150)
!161 = !DILocation(line: 86, column: 26, scope: !70, inlinedAt: !150)
!162 = !DILocation(line: 86, column: 5, scope: !66, inlinedAt: !150)
!163 = !DILocation(line: 151, column: 1, scope: !14)
!164 = !DILocation(line: 81, column: 32, scope: !59)
!165 = !DILocation(line: 81, column: 42, scope: !59)
!166 = !DILocation(line: 81, column: 52, scope: !59)
!167 = !DILocation(line: 81, column: 68, scope: !59)
!168 = !DILocation(line: 82, column: 32, scope: !59)
!169 = !DILocation(line: 86, column: 17, scope: !66)
!170 = !DILocation(line: 86, column: 26, scope: !70)
!171 = !DILocation(line: 87, column: 21, scope: !68)
!172 = !DILocation(line: 88, column: 23, scope: !84)
!173 = !DILocation(line: 88, column: 13, scope: !84)
!174 = !DILocation(line: 88, column: 21, scope: !84)
!175 = !DILocation(line: 87, column: 36, scope: !85)
!176 = !DILocation(line: 87, column: 30, scope: !85)
!177 = !DILocation(line: 86, column: 32, scope: !70)
!178 = !DILocation(line: 93, column: 1, scope: !59)
!179 = distinct !DISubprogram(name: "trans_tmp", scope: !1, file: !1, line: 101, type: !15, isLocal: true, isDefinition: true, scopeLine: 102, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !180)
!180 = !{!181, !182, !183, !184, !185, !186, !188, !192, !195}
!181 = !DILocalVariable(name: "M", arg: 1, scope: !179, file: !1, line: 101, type: !17)
!182 = !DILocalVariable(name: "N", arg: 2, scope: !179, file: !1, line: 101, type: !17)
!183 = !DILocalVariable(name: "A", arg: 3, scope: !179, file: !1, line: 101, type: !20)
!184 = !DILocalVariable(name: "B", arg: 4, scope: !179, file: !1, line: 101, type: !20)
!185 = !DILocalVariable(name: "tmp", arg: 5, scope: !179, file: !1, line: 102, type: !25)
!186 = !DILocalVariable(name: "i", scope: !187, file: !1, line: 106, type: !17)
!187 = distinct !DILexicalBlock(scope: !179, file: !1, line: 106, column: 5)
!188 = !DILocalVariable(name: "j", scope: !189, file: !1, line: 107, type: !17)
!189 = distinct !DILexicalBlock(scope: !190, file: !1, line: 107, column: 9)
!190 = distinct !DILexicalBlock(scope: !191, file: !1, line: 106, column: 36)
!191 = distinct !DILexicalBlock(scope: !187, file: !1, line: 106, column: 5)
!192 = !DILocalVariable(name: "di", scope: !193, file: !1, line: 108, type: !17)
!193 = distinct !DILexicalBlock(scope: !194, file: !1, line: 107, column: 40)
!194 = distinct !DILexicalBlock(scope: !189, file: !1, line: 107, column: 9)
!195 = !DILocalVariable(name: "dj", scope: !193, file: !1, line: 109, type: !17)
!196 = !DILocation(line: 101, column: 30, scope: !179)
!197 = !DILocation(line: 101, column: 40, scope: !179)
!198 = !DILocation(line: 101, column: 50, scope: !179)
!199 = !DILocation(line: 101, column: 66, scope: !179)
!200 = !DILocation(line: 102, column: 30, scope: !179)
!201 = !DILocation(line: 106, column: 17, scope: !187)
!202 = !DILocation(line: 106, column: 26, scope: !191)
!203 = !DILocation(line: 106, column: 5, scope: !187)
!204 = !DILocation(line: 107, column: 21, scope: !189)
!205 = !DILocation(line: 107, column: 9, scope: !189)
!206 = !DILocation(line: 108, column: 20, scope: !193)
!207 = !DILocation(line: 109, column: 27, scope: !193)
!208 = !DILocation(line: 109, column: 20, scope: !193)
!209 = !DILocation(line: 110, column: 32, scope: !193)
!210 = !DILocation(line: 110, column: 24, scope: !193)
!211 = !DILocation(line: 110, column: 13, scope: !193)
!212 = !DILocation(line: 110, column: 30, scope: !193)
!213 = !DILocation(line: 111, column: 13, scope: !193)
!214 = !DILocation(line: 111, column: 21, scope: !193)
!215 = !DILocation(line: 107, column: 36, scope: !194)
!216 = !DILocation(line: 107, column: 30, scope: !194)
!217 = distinct !{!217, !205, !218}
!218 = !DILocation(line: 112, column: 9, scope: !189)
!219 = !DILocation(line: 106, column: 32, scope: !191)
!220 = distinct !{!220, !203, !221}
!221 = !DILocation(line: 113, column: 5, scope: !187)
!222 = !DILocation(line: 116, column: 1, scope: !179)
