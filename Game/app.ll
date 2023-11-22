; ModuleID = 'app.bc'
source_filename = "app.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noreturn nounwind uwtable
define dso_local void @app() local_unnamed_addr #0 {
  %1 = alloca [120 x [120 x i32]], align 16
  %2 = alloca [120 x [120 x i32]], align 16
  %3 = bitcast [120 x [120 x i32]]* %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 57600, i8* nonnull %3) #3
  %4 = bitcast [120 x [120 x i32]]* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 57600, i8* nonnull %4) #3
  %5 = ptrtoint [120 x [120 x i32]]* %1 to i64
  %6 = ptrtoint [120 x [120 x i32]]* %2 to i64
  %7 = call i32 @Lib_Rand(i32 1000, i32 5000) #3
  %8 = icmp sgt i32 %7, 0
  br i1 %8, label %9, label %19

9:                                                ; preds = %0, %9
  %10 = phi i32 [ %17, %9 ], [ 0, %0 ]
  %11 = call i32 @Lib_Rand(i32 0, i32 119) #3
  %12 = sext i32 %11 to i64
  %13 = call i32 @Lib_Rand(i32 0, i32 119) #3
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %1, i64 0, i64 %14, i64 %12
  store i32 1, i32* %15, align 4, !tbaa !2
  %16 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %14, i64 %12
  store i32 0, i32* %16, align 4, !tbaa !2
  %17 = add nuw nsw i32 %10, 1
  %18 = icmp eq i32 %17, %7
  br i1 %18, label %19, label %9

19:                                               ; preds = %9, %0
  br label %20

20:                                               ; preds = %19, %60
  %21 = phi i64 [ %22, %60 ], [ %5, %19 ]
  %22 = phi i64 [ %21, %60 ], [ %6, %19 ]
  %23 = inttoptr i64 %21 to [120 x [120 x i32]]*
  %24 = inttoptr i64 %22 to [120 x [120 x i32]]*
  %25 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %23, i64 0, i64 0
  br label %26

26:                                               ; preds = %29, %20
  %27 = phi i64 [ 0, %20 ], [ %30, %29 ]
  %28 = trunc i64 %27 to i32
  br label %32

29:                                               ; preds = %32
  %30 = add nuw nsw i64 %27, 1
  %31 = icmp eq i64 %30, 120
  br i1 %31, label %47, label %26

32:                                               ; preds = %32, %26
  %33 = phi i64 [ 0, %26 ], [ %45, %32 ]
  %34 = trunc i64 %33 to i32
  %35 = call i32 @Lib_CountAliveNeighbors([120 x i32]* %25, i32 %28, i32 %34) #3
  %36 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %23, i64 0, i64 %27, i64 %33
  %37 = load i32, i32* %36, align 4, !tbaa !2
  %38 = icmp eq i32 %37, 1
  %39 = and i32 %35, -2
  %40 = icmp eq i32 %39, 2
  %41 = icmp eq i32 %35, 3
  %42 = select i1 %38, i1 %40, i1 %41
  %43 = zext i1 %42 to i32
  %44 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %24, i64 0, i64 %27, i64 %33
  store i32 %43, i32* %44, align 4
  %45 = add nuw nsw i64 %33, 1
  %46 = icmp eq i64 %45, 120
  br i1 %46, label %29, label %32

47:                                               ; preds = %29, %50
  %48 = phi i64 [ %51, %50 ], [ 0, %29 ]
  %49 = trunc i64 %48 to i32
  br label %53

50:                                               ; preds = %53
  %51 = add nuw nsw i64 %48, 1
  %52 = icmp eq i64 %51, 120
  br i1 %52, label %60, label %47

53:                                               ; preds = %53, %47
  %54 = phi i64 [ 0, %47 ], [ %58, %53 ]
  %55 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %24, i64 0, i64 %48, i64 %54
  %56 = load i32, i32* %55, align 4, !tbaa !2
  %57 = trunc i64 %54 to i32
  call void @Lib_DrawCell(i32 %49, i32 %57, i32 %56) #3
  %58 = add nuw nsw i64 %54, 1
  %59 = icmp eq i64 %58, 120
  br i1 %59, label %50, label %53

60:                                               ; preds = %50
  call void (...) @Lib_Display() #3
  br label %20
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

declare dso_local void @Lib_Display(...) local_unnamed_addr #2

declare dso_local i32 @Lib_Rand(i32, i32) local_unnamed_addr #2

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
