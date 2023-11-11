; ModuleID = 'app.bc'
source_filename = "app.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noreturn nounwind uwtable
define dso_local void @app() local_unnamed_addr #0 {
  
  ; ALLOCATE x1
  %1 = alloca [120 x [120 x i32]], align 16
  ; ALLOCATE x2
  %2 = alloca [120 x [120 x i32]], align 16
  
  ; BITCAST x3, x1                                        
  %3 = bitcast [120 x [120 x i32]]* %1 to i8*

  ; LIFETIME_START x3
  call void @llvm.lifetime.start.p0i8(i64 57600, i8* nonnull %3) #3

  ; BITCAST x4, x2                                        
  %4 = bitcast [120 x [120 x i32]]* %2 to i8*

  ; LIFETIME_START x4
  call void @llvm.lifetime.start.p0i8(i64 57600, i8* nonnull %4) #3
  
  ; PTRTOINT x5, x1

  ; PTRTOINT x6, x2
  %5 = ptrtoint [120 x [120 x i32]]* %1 to i64
  %6 = ptrtoint [120 x [120 x i32]]* %2 to i64

  ; RAND x7, 1000, 5000
  %7 = call i64 @Lib_Rand(i32 1000, i32 5000) #3

  ; TRUNC x7, x7 (my_trunc in asm is i64 i32 by default)
  %8 = trunc i64 %7 to i32

  ; PHI(11) STUFF:
  ; XOR x8, x8

  ; SGT_BR x7, label10, label18
    %9 = icmp sgt i32 %8, 0
    br i1 %9, label %10, label %18

10:                                               ; preds = %0, %10

  ;%11 = phi i32 [ %16, %10 ], [ 0, %0 ]
  
  ; RAND x9, 0, 119
  %12 = call i64 @Lib_Rand(i32 0, i32 119) #3

  ; RAND x10, 0, 119
  %13 = call i64 @Lib_Rand(i32 0, i32 119) #3
  
  ; GEP_DEFAULT x11, x1, x10, x9
  %14 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %1, i64 0, i64 %13, i64 %12
  ; STORE 1, x11
  store i32 1, i32* %14, align 4, !tbaa !2
  
  ; GEP_DEFAULT x12, x2, x10, x9
  %15 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %13, i64 %12
  ; STORE 0, x12
  store i32 0, i32* %15, align 4, !tbaa !2

  ; INC_EQ x32, x8, x7
    %16 = add nuw nsw i32 %11, 1
    %17 = icmp eq i32 %16, %8
  ; BR_COND x32, label18, label10
  br i1 %17, label %18, label %10

18:                                               ; preds = %10, %0
  ; BRR label19
  br label %19

19:                                               ; preds = %18, %59
  
  ; 
  ;%20 = phi i64 [ %21, %59 ], [ %5, %18 ]
  ;%21 = phi i64 [ %20, %59 ], [ %6, %18 ]

  ; INTTOPTR x13, x5
  %22 = inttoptr i64 %20 to [120 x [120 x i32]]*
  
  ; INTTOPTR x14, x6
  %23 = inttoptr i64 %21 to [120 x [120 x i32]]*
  
  ; GEP x15, x13
  %24 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %22, i64 0, i64 0
  
  ; BR label25
  br label %25

25:                                               ; preds = %28, %19
  ;%26 = phi i64 [ 0, %19 ], [ %29, %28 ]
  
  ; TRUNC x17, x16
  %27 = trunc i64 %26 to i32
  
  ; PHI STUFF:
  ; XOR x18 x18

  ; BR label31
  br label %31

28:                                               ; preds = %31
  
  ; INC_EQ x31, x16, 120
  %29 = add nuw nsw i64 %26, 1
  %30 = icmp eq i64 %29, 120

  ; PHI STUFF:
  ; XOR x16 x16
  ; XOR x27 x27

  ; BR x31, label46, label25
  br i1 %30, label %46, label %25

31:                                               ; preds = %31, %25
  
  ;%32 = phi i64 [ 0, %25 ], [ %44, %31 ]
  
  ; TRUNC x19, x18
  %33 = trunc i64 %32 to i32
  
  ; CNT_ALIVE x20, x15, x17, x19
  %34 = call i32 @Lib_CountAliveNeighbors([120 x i32]* %24, i32 %27, i32 %33) #3
 
  ; GEP_LOAD x21, x13, x16, x18
    %35 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %22, i64 0, i64 %26, i64 %32
    %36 = load i32, i32* %35, align 4, !tbaa !2
  
  ; CMP_EQ x22, x21, 1
  %37 = icmp eq i32 %36, 1
  
  ; AND_EQ x23, x20, -2, 2
    %38 = and i32 %34, -2
    %39 = icmp eq i32 %38, 2

  ; EQ_SELECT  x24, x20, x22, x23
    %40 = icmp eq i32 %34, 3
    %41 = select i1 %37, i1 %39, i1 %40
  
  ; ZEXT x25, x24
  %42 = zext i1 %41 to i32
  
  ; GEP_STORE x25, x14, x16, x18
    %43 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %23, i64 0, i64 %26, i64 %32
    store i32 %42, i32* %43, align 4
  
  ; INC x18
  %44 = add nuw nsw i64 %32, 1
  
  ; EQ_BR x18, label28, label31
    %45 = icmp eq i64 %44, 120
    br i1 %45, label %28, label %31

46:                                               ; preds = %28, %49
  ;%47 = phi i64 [ %50, %49 ], [ 0, %28 ]
  
  ; TRUNC x28, x27
  %48 = trunc i64 %47 to i32

  ; PHI STUFF:
  ; XOR x30 x30

  ; BR label52
  br label %52

49:                                               ; preds = %52
  
  ; x27
  %50 = add nuw nsw i64 %47, 1
  

  ; EQ_BR x27, 120, label59, label46
    %51 = icmp eq i64 %50, 120
    br i1 %51, label %59, label %46

52:                                               ; preds = %52, %46
  
  ;%53 = phi i64 [ 0, %46 ], [ %57, %52 ]
  
  ; GEP_LOAD x26, x14, x27, x30
    %54 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %23, i64 0, i64 %47, i64 %53
    %55 = load i32, i32* %54, align 4, !tbaa !2
  
  ; TRUNC x29, x30
  %56 = trunc i64 %53 to i32

  ; DRAW x28, x29, x26
  call void @Lib_DrawCell(i32 %48, i32 %56, i32 %55) #3
  
  ; INC x30
  %57 = add nuw nsw i64 %53, 1
  
  ; EQ_BR x30, 120, label49, label52
    %58 = icmp eq i64 %57, 120
    br i1 %58, label %49, label %52

59:                                               ; preds = %49
  ; DISPLAY
  call void (...) @Lib_Display() #3
  
  ; PHI STUFF
  ; SWAP x5, x6
  
  ; BR label19
  br label %19
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

declare dso_local void @Lib_Display(...) local_unnamed_addr #2

declare dso_local i64 @Lib_Rand(i32, i32) local_unnamed_addr #2

declare dso_local i32 @Lib_CountAliveNeighbors([120 x i32]*, i32, i32) local_unnamed_addr #2

declare dso_local void @Lib_DrawCell(i32, i32, i32) local_unnamed_addr #2

attributes #0 = { noreturn nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1 "}
!2 = !{!3, !3, i64 0}
!3 = !{!"int", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
