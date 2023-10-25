; ModuleID = 'app.bc'
source_filename = "app.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local void @UpdateGrid([120 x [120 x i32]]* %grid) local_unnamed_addr #0 {
entry:
  %newGrid = alloca [120 x [120 x i32]], align 16
  %0 = bitcast [120 x [120 x i32]]* %newGrid to i8*
  call void @llvm.lifetime.start.p0i8(i64 57600, i8* nonnull %0) #4
  %arraydecay = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 0
  br label %for.cond1.preheader

for.cond1.preheader:                              ; preds = %for.cond.cleanup3, %entry
  %indvars.iv71 = phi i64 [ 0, %entry ], [ %indvars.iv.next72, %for.cond.cleanup3 ]
  %1 = trunc i64 %indvars.iv71 to i32
  br label %for.body4

for.cond.cleanup3:                                ; preds = %lor.end
  %indvars.iv.next72 = add nuw nsw i64 %indvars.iv71, 1
  %exitcond73 = icmp eq i64 %indvars.iv.next72, 120
  br i1 %exitcond73, label %for.cond22.preheader, label %for.cond1.preheader

for.body4:                                        ; preds = %lor.end, %for.cond1.preheader
  %indvars.iv = phi i64 [ 0, %for.cond1.preheader ], [ %indvars.iv.next, %lor.end ]
  %2 = trunc i64 %indvars.iv to i32
  %call = tail call i32 @Lib_CountAliveNeighbors([120 x i32]* %arraydecay, i32 %1, i32 %2) #4
  switch i32 %call, label %lor.end.fold.split [
    i32 3, label %lor.end
    i32 2, label %land.rhs
  ]

land.rhs:                                         ; preds = %for.body4
  %arrayidx8 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvars.iv71, i64 %indvars.iv
  %3 = load i32, i32* %arrayidx8, align 4, !tbaa !2
  %tobool = icmp ne i32 %3, 0
  br label %lor.end

lor.end.fold.split:                               ; preds = %for.body4
  br label %lor.end

lor.end:                                          ; preds = %for.body4, %lor.end.fold.split, %land.rhs
  %4 = phi i1 [ true, %for.body4 ], [ %tobool, %land.rhs ], [ false, %lor.end.fold.split ]
  %lor.ext = zext i1 %4 to i32
  %arrayidx12 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid, i64 0, i64 %indvars.iv71, i64 %indvars.iv
  store i32 %lor.ext, i32* %arrayidx12, align 4, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond70 = icmp eq i64 %indvars.iv.next, 120
  br i1 %exitcond70, label %for.cond.cleanup3, label %for.body4

for.cond22.preheader:                             ; preds = %for.cond.cleanup3, %for.cond22.preheader
  %indvar = phi i64 [ %indvar.next.2, %for.cond22.preheader ], [ 0, %for.cond.cleanup3 ]
  %scevgep = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvar, i64 0
  %scevgep67 = bitcast i32* %scevgep to i8*
  %scevgep68 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid, i64 0, i64 %indvar, i64 0
  %scevgep6869 = bitcast i32* %scevgep68 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(480) %scevgep67, i8* nonnull align 16 dereferenceable(480) %scevgep6869, i64 480, i1 false)
  %indvar.next = add nuw nsw i64 %indvar, 1
  %scevgep.1 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvar.next, i64 0
  %scevgep67.1 = bitcast i32* %scevgep.1 to i8*
  %scevgep68.1 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid, i64 0, i64 %indvar.next, i64 0
  %scevgep6869.1 = bitcast i32* %scevgep68.1 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(480) %scevgep67.1, i8* nonnull align 16 dereferenceable(480) %scevgep6869.1, i64 480, i1 false)
  %indvar.next.1 = add nuw nsw i64 %indvar, 2
  %scevgep.2 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvar.next.1, i64 0
  %scevgep67.2 = bitcast i32* %scevgep.2 to i8*
  %scevgep68.2 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid, i64 0, i64 %indvar.next.1, i64 0
  %scevgep6869.2 = bitcast i32* %scevgep68.2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(480) %scevgep67.2, i8* nonnull align 16 dereferenceable(480) %scevgep6869.2, i64 480, i1 false)
  %indvar.next.2 = add nuw nsw i64 %indvar, 3
  %exitcond.2 = icmp eq i64 %indvar.next.2, 120
  br i1 %exitcond.2, label %for.cond.cleanup19, label %for.cond22.preheader

for.cond.cleanup19:                               ; preds = %for.cond22.preheader
  call void @llvm.lifetime.end.p0i8(i64 57600, i8* nonnull %0) #4
  ret void
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

declare dso_local i32 @Lib_CountAliveNeighbors([120 x i32]*, i32, i32) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: noreturn nounwind uwtable
define dso_local void @app() local_unnamed_addr #3 {
entry:
  %newGrid.i = alloca [120 x [120 x i32]], align 16
  %grid = alloca [120 x [120 x i32]], align 16
  %0 = bitcast [120 x [120 x i32]]* %grid to i8*
  call void @llvm.lifetime.start.p0i8(i64 57600, i8* nonnull %0) #4
  call void @llvm.memset.p0i8.i64(i8* nonnull align 16 dereferenceable(57600) %0, i8 0, i64 57600, i1 false)
  %call = tail call i32 @Lib_Rand(i32 1000, i32 2000) #4
  %cmp39 = icmp sgt i32 %call, 0
  br i1 %cmp39, label %for.body, label %while.cond.preheader

while.cond.preheader:                             ; preds = %for.body, %entry
  %1 = bitcast [120 x [120 x i32]]* %newGrid.i to i8*
  %arraydecay.i = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 0
  br label %while.cond

for.body:                                         ; preds = %entry, %for.body
  %i.040 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  %call1 = tail call i32 @Lib_Rand(i32 0, i32 119) #4
  %call2 = tail call i32 @Lib_Rand(i32 0, i32 119) #4
  %idxprom = sext i32 %call2 to i64
  %idxprom3 = sext i32 %call1 to i64
  %arrayidx4 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %idxprom, i64 %idxprom3
  store i32 1, i32* %arrayidx4, align 4, !tbaa !2
  %inc = add nuw nsw i32 %i.040, 1
  %exitcond44 = icmp eq i32 %inc, %call
  br i1 %exitcond44, label %while.cond.preheader, label %for.body

while.cond:                                       ; preds = %while.cond.preheader, %for.cond.cleanup8
  call void @llvm.lifetime.start.p0i8(i64 57600, i8* nonnull %1) #4
  br label %for.cond1.preheader.i

for.cond1.preheader.i:                            ; preds = %for.cond.cleanup3.i, %while.cond
  %indvars.iv71.i = phi i64 [ 0, %while.cond ], [ %indvars.iv.next72.i, %for.cond.cleanup3.i ]
  %2 = trunc i64 %indvars.iv71.i to i32
  br label %for.body4.i

for.cond.cleanup3.i:                              ; preds = %lor.end.i
  %indvars.iv.next72.i = add nuw nsw i64 %indvars.iv71.i, 1
  %exitcond73.i = icmp eq i64 %indvars.iv.next72.i, 120
  br i1 %exitcond73.i, label %for.cond22.preheader.i, label %for.cond1.preheader.i

for.body4.i:                                      ; preds = %lor.end.i, %for.cond1.preheader.i
  %indvars.iv.i = phi i64 [ 0, %for.cond1.preheader.i ], [ %indvars.iv.next.i, %lor.end.i ]
  %3 = trunc i64 %indvars.iv.i to i32
  %call.i = call i32 @Lib_CountAliveNeighbors([120 x i32]* nonnull %arraydecay.i, i32 %2, i32 %3) #4
  switch i32 %call.i, label %lor.end.fold.split.i [
    i32 3, label %lor.end.i
    i32 2, label %land.rhs.i
  ]

land.rhs.i:                                       ; preds = %for.body4.i
  %arrayidx8.i = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvars.iv71.i, i64 %indvars.iv.i
  %4 = load i32, i32* %arrayidx8.i, align 4, !tbaa !2
  %tobool.i = icmp ne i32 %4, 0
  br label %lor.end.i

lor.end.fold.split.i:                             ; preds = %for.body4.i
  br label %lor.end.i

lor.end.i:                                        ; preds = %lor.end.fold.split.i, %land.rhs.i, %for.body4.i
  %5 = phi i1 [ true, %for.body4.i ], [ %tobool.i, %land.rhs.i ], [ false, %lor.end.fold.split.i ]
  %lor.ext.i = zext i1 %5 to i32
  %arrayidx12.i = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid.i, i64 0, i64 %indvars.iv71.i, i64 %indvars.iv.i
  store i32 %lor.ext.i, i32* %arrayidx12.i, align 4, !tbaa !2
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i, 1
  %exitcond70.i = icmp eq i64 %indvars.iv.next.i, 120
  br i1 %exitcond70.i, label %for.cond.cleanup3.i, label %for.body4.i

for.cond22.preheader.i:                           ; preds = %for.cond.cleanup3.i, %for.cond22.preheader.i
  %indvar.i = phi i64 [ %indvar.next.i.2, %for.cond22.preheader.i ], [ 0, %for.cond.cleanup3.i ]
  %scevgep.i = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvar.i, i64 0
  %scevgep67.i = bitcast i32* %scevgep.i to i8*
  %scevgep68.i = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid.i, i64 0, i64 %indvar.i, i64 0
  %scevgep6869.i = bitcast i32* %scevgep68.i to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 dereferenceable(480) %scevgep67.i, i8* nonnull align 16 dereferenceable(480) %scevgep6869.i, i64 480, i1 false) #4
  %indvar.next.i = add nuw nsw i64 %indvar.i, 1
  %scevgep.i.1 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvar.next.i, i64 0
  %scevgep67.i.1 = bitcast i32* %scevgep.i.1 to i8*
  %scevgep68.i.1 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid.i, i64 0, i64 %indvar.next.i, i64 0
  %scevgep6869.i.1 = bitcast i32* %scevgep68.i.1 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 dereferenceable(480) %scevgep67.i.1, i8* nonnull align 16 dereferenceable(480) %scevgep6869.i.1, i64 480, i1 false) #4
  %indvar.next.i.1 = add nuw nsw i64 %indvar.i, 2
  %scevgep.i.2 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvar.next.i.1, i64 0
  %scevgep67.i.2 = bitcast i32* %scevgep.i.2 to i8*
  %scevgep68.i.2 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid.i, i64 0, i64 %indvar.next.i.1, i64 0
  %scevgep6869.i.2 = bitcast i32* %scevgep68.i.2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 dereferenceable(480) %scevgep67.i.2, i8* nonnull align 16 dereferenceable(480) %scevgep6869.i.2, i64 480, i1 false) #4
  %indvar.next.i.2 = add nuw nsw i64 %indvar.i, 3
  %exitcond.i.2 = icmp eq i64 %indvar.next.i.2, 120
  br i1 %exitcond.i.2, label %UpdateGrid.exit, label %for.cond22.preheader.i

UpdateGrid.exit:                                  ; preds = %for.cond22.preheader.i
  call void @llvm.lifetime.end.p0i8(i64 57600, i8* nonnull %1) #4
  br label %for.cond11.preheader

for.cond11.preheader:                             ; preds = %for.cond.cleanup13, %UpdateGrid.exit
  %indvars.iv41 = phi i64 [ 0, %UpdateGrid.exit ], [ %indvars.iv.next42, %for.cond.cleanup13 ]
  %6 = trunc i64 %indvars.iv41 to i32
  br label %for.body14

for.cond.cleanup8:                                ; preds = %for.cond.cleanup13
  call void (...) @Lib_Display() #4
  br label %while.cond

for.cond.cleanup13:                               ; preds = %for.body14
  %indvars.iv.next42 = add nuw nsw i64 %indvars.iv41, 1
  %exitcond43 = icmp eq i64 %indvars.iv.next42, 120
  br i1 %exitcond43, label %for.cond.cleanup8, label %for.cond11.preheader

for.body14:                                       ; preds = %for.body14, %for.cond11.preheader
  %indvars.iv = phi i64 [ 0, %for.cond11.preheader ], [ %indvars.iv.next, %for.body14 ]
  %arrayidx18 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvars.iv41, i64 %indvars.iv
  %7 = load i32, i32* %arrayidx18, align 4, !tbaa !2
  %8 = trunc i64 %indvars.iv to i32
  call void @Lib_DrawCell(i32 %6, i32 %8, i32 %7) #4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 120
  br i1 %exitcond, label %for.cond.cleanup13, label %for.body14
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #1

declare dso_local i32 @Lib_Rand(i32, i32) local_unnamed_addr #2

declare dso_local void @Lib_DrawCell(i32, i32, i32) local_unnamed_addr #2

declare dso_local void @Lib_Display(...) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #1
