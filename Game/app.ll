; ModuleID = 'app.bc'
source_filename = "app.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local void @InitGrid([120 x i32]* nocapture %grid) local_unnamed_addr #0 {
entry:
  %call = tail call i32 @Lib_Rand(i32 1000, i32 2000) #5
  %cmp10 = icmp sgt i32 %call, 0
  br i1 %cmp10, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %i.011 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  %call1 = tail call i32 @Lib_Rand(i32 0, i32 119) #5
  %call2 = tail call i32 @Lib_Rand(i32 0, i32 119) #5
  %idxprom = sext i32 %call2 to i64
  %idxprom3 = sext i32 %call1 to i64
  %arrayidx4 = getelementptr inbounds [120 x i32], [120 x i32]* %grid, i64 %idxprom, i64 %idxprom3
  store i32 1, i32* %arrayidx4, align 4, !tbaa !2
  %inc = add nuw nsw i32 %i.011, 1
  %exitcond = icmp eq i32 %inc, %call
  br i1 %exitcond, label %for.cond.cleanup, label %for.body
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

declare dso_local i32 @Lib_Rand(i32, i32) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: norecurse nounwind readonly uwtable
define dso_local i32 @CountAliveNeighbors([120 x i32]* nocapture readonly %grid, i32 %x, i32 %y) local_unnamed_addr #3 {
entry:
  %add = add nsw i32 %x, -1
  %add3 = add nsw i32 %y, -1
  %0 = icmp ult i32 %add, 120
  %1 = icmp ult i32 %add3, 120
  %2 = and i1 %0, %1
  br i1 %2, label %if.then, label %if.end16

if.then:                                          ; preds = %entry
  %idxprom1032 = zext i32 %add to i64
  %idxprom1233 = zext i32 %add3 to i64
  %arrayidx13 = getelementptr inbounds [120 x i32], [120 x i32]* %grid, i64 %idxprom1032, i64 %idxprom1233
  %3 = load i32, i32* %arrayidx13, align 4, !tbaa !2
  %cmp14 = icmp eq i32 %3, 1
  %inc = zext i1 %cmp14 to i32
  br label %if.end16

if.end16:                                         ; preds = %if.then, %entry
  %aliveNeighbors.1 = phi i32 [ 0, %entry ], [ %inc, %if.then ]
  %4 = icmp ult i32 %x, 120
  %5 = and i1 %4, %1
  br i1 %5, label %if.then.1, label %if.end16.1

if.then.1:                                        ; preds = %if.end16
  %idxprom1032.1 = zext i32 %x to i64
  %idxprom1233.1 = zext i32 %add3 to i64
  %arrayidx13.1 = getelementptr inbounds [120 x i32], [120 x i32]* %grid, i64 %idxprom1032.1, i64 %idxprom1233.1
  %6 = load i32, i32* %arrayidx13.1, align 4, !tbaa !2
  %cmp14.1 = icmp eq i32 %6, 1
  %inc.1 = zext i1 %cmp14.1 to i32
  %spec.select.1 = add nuw nsw i32 %aliveNeighbors.1, %inc.1
  br label %if.end16.1

if.end16.1:                                       ; preds = %if.then.1, %if.end16
  %aliveNeighbors.1.1 = phi i32 [ %aliveNeighbors.1, %if.end16 ], [ %spec.select.1, %if.then.1 ]
  %add.2 = add nsw i32 %x, 1
  %7 = icmp ult i32 %add.2, 120
  %8 = and i1 %7, %1
  br i1 %8, label %if.then.2, label %if.end16.2

if.then.2:                                        ; preds = %if.end16.1
  %idxprom1032.2 = zext i32 %add.2 to i64
  %idxprom1233.2 = zext i32 %add3 to i64
  %arrayidx13.2 = getelementptr inbounds [120 x i32], [120 x i32]* %grid, i64 %idxprom1032.2, i64 %idxprom1233.2
  %9 = load i32, i32* %arrayidx13.2, align 4, !tbaa !2
  %cmp14.2 = icmp eq i32 %9, 1
  %inc.2 = zext i1 %cmp14.2 to i32
  %spec.select.2 = add nuw nsw i32 %aliveNeighbors.1.1, %inc.2
  br label %if.end16.2

if.end16.2:                                       ; preds = %if.then.2, %if.end16.1
  %aliveNeighbors.1.2 = phi i32 [ %aliveNeighbors.1.1, %if.end16.1 ], [ %spec.select.2, %if.then.2 ]
  %10 = icmp ult i32 %y, 120
  %11 = and i1 %0, %10
  br i1 %11, label %if.then.3, label %if.end16.3

if.then.3:                                        ; preds = %if.end16.2
  %idxprom1032.3 = zext i32 %add to i64
  %idxprom1233.3 = zext i32 %y to i64
  %arrayidx13.3 = getelementptr inbounds [120 x i32], [120 x i32]* %grid, i64 %idxprom1032.3, i64 %idxprom1233.3
  %12 = load i32, i32* %arrayidx13.3, align 4, !tbaa !2
  %cmp14.3 = icmp eq i32 %12, 1
  %inc.3 = zext i1 %cmp14.3 to i32
  %spec.select.3 = add nuw nsw i32 %aliveNeighbors.1.2, %inc.3
  br label %if.end16.3

if.end16.3:                                       ; preds = %if.then.3, %if.end16.2
  %aliveNeighbors.1.3 = phi i32 [ %aliveNeighbors.1.2, %if.end16.2 ], [ %spec.select.3, %if.then.3 ]
  %13 = and i1 %7, %10
  br i1 %13, label %if.then.4, label %if.end16.4

if.then.4:                                        ; preds = %if.end16.3
  %idxprom1032.4 = zext i32 %add.2 to i64
  %idxprom1233.4 = zext i32 %y to i64
  %arrayidx13.4 = getelementptr inbounds [120 x i32], [120 x i32]* %grid, i64 %idxprom1032.4, i64 %idxprom1233.4
  %14 = load i32, i32* %arrayidx13.4, align 4, !tbaa !2
  %cmp14.4 = icmp eq i32 %14, 1
  %inc.4 = zext i1 %cmp14.4 to i32
  %spec.select.4 = add nuw nsw i32 %aliveNeighbors.1.3, %inc.4
  br label %if.end16.4

if.end16.4:                                       ; preds = %if.then.4, %if.end16.3
  %aliveNeighbors.1.4 = phi i32 [ %aliveNeighbors.1.3, %if.end16.3 ], [ %spec.select.4, %if.then.4 ]
  %add3.5 = add nsw i32 %y, 1
  %15 = icmp ult i32 %add3.5, 120
  %16 = and i1 %0, %15
  br i1 %16, label %if.then.5, label %if.end16.5

if.then.5:                                        ; preds = %if.end16.4
  %idxprom1032.5 = zext i32 %add to i64
  %idxprom1233.5 = zext i32 %add3.5 to i64
  %arrayidx13.5 = getelementptr inbounds [120 x i32], [120 x i32]* %grid, i64 %idxprom1032.5, i64 %idxprom1233.5
  %17 = load i32, i32* %arrayidx13.5, align 4, !tbaa !2
  %cmp14.5 = icmp eq i32 %17, 1
  %inc.5 = zext i1 %cmp14.5 to i32
  %spec.select.5 = add nuw nsw i32 %aliveNeighbors.1.4, %inc.5
  br label %if.end16.5

if.end16.5:                                       ; preds = %if.then.5, %if.end16.4
  %aliveNeighbors.1.5 = phi i32 [ %aliveNeighbors.1.4, %if.end16.4 ], [ %spec.select.5, %if.then.5 ]
  %18 = and i1 %4, %15
  br i1 %18, label %if.then.6, label %if.end16.6

if.then.6:                                        ; preds = %if.end16.5
  %idxprom1032.6 = zext i32 %x to i64
  %idxprom1233.6 = zext i32 %add3.5 to i64
  %arrayidx13.6 = getelementptr inbounds [120 x i32], [120 x i32]* %grid, i64 %idxprom1032.6, i64 %idxprom1233.6
  %19 = load i32, i32* %arrayidx13.6, align 4, !tbaa !2
  %cmp14.6 = icmp eq i32 %19, 1
  %inc.6 = zext i1 %cmp14.6 to i32
  %spec.select.6 = add nuw nsw i32 %aliveNeighbors.1.5, %inc.6
  br label %if.end16.6

if.end16.6:                                       ; preds = %if.then.6, %if.end16.5
  %aliveNeighbors.1.6 = phi i32 [ %aliveNeighbors.1.5, %if.end16.5 ], [ %spec.select.6, %if.then.6 ]
  %20 = and i1 %7, %15
  br i1 %20, label %if.then.7, label %if.end16.7

if.then.7:                                        ; preds = %if.end16.6
  %idxprom1032.7 = zext i32 %add.2 to i64
  %idxprom1233.7 = zext i32 %add3.5 to i64
  %arrayidx13.7 = getelementptr inbounds [120 x i32], [120 x i32]* %grid, i64 %idxprom1032.7, i64 %idxprom1233.7
  %21 = load i32, i32* %arrayidx13.7, align 4, !tbaa !2
  %cmp14.7 = icmp eq i32 %21, 1
  %inc.7 = zext i1 %cmp14.7 to i32
  %spec.select.7 = add nuw nsw i32 %aliveNeighbors.1.6, %inc.7
  br label %if.end16.7

if.end16.7:                                       ; preds = %if.then.7, %if.end16.6
  %aliveNeighbors.1.7 = phi i32 [ %aliveNeighbors.1.6, %if.end16.6 ], [ %spec.select.7, %if.then.7 ]
  ret i32 %aliveNeighbors.1.7
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: nounwind uwtable
define dso_local void @UpdateGrid([120 x [120 x i32]]* nocapture %grid) local_unnamed_addr #0 {
entry:
  %newGrid = alloca [120 x [120 x i32]], align 16
  %0 = bitcast [120 x [120 x i32]]* %newGrid to i8*
  call void @llvm.lifetime.start.p0i8(i64 57600, i8* nonnull %0) #5
  br label %for.cond1.preheader

for.cond1.preheader:                              ; preds = %for.cond1.preheader, %entry
  %indvar123 = phi i64 [ 0, %entry ], [ %indvar.next124.2, %for.cond1.preheader ]
  %scevgep125 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid, i64 0, i64 %indvar123, i64 0
  %scevgep125126 = bitcast i32* %scevgep125 to i8*
  %scevgep127 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvar123, i64 0
  %scevgep127128 = bitcast i32* %scevgep127 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 dereferenceable(480) %scevgep125126, i8* nonnull align 4 dereferenceable(480) %scevgep127128, i64 480, i1 false)
  %indvar.next124 = add nuw nsw i64 %indvar123, 1
  %scevgep125.1 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid, i64 0, i64 %indvar.next124, i64 0
  %scevgep125126.1 = bitcast i32* %scevgep125.1 to i8*
  %scevgep127.1 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvar.next124, i64 0
  %scevgep127128.1 = bitcast i32* %scevgep127.1 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 dereferenceable(480) %scevgep125126.1, i8* nonnull align 4 dereferenceable(480) %scevgep127128.1, i64 480, i1 false)
  %indvar.next124.1 = add nuw nsw i64 %indvar123, 2
  %scevgep125.2 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid, i64 0, i64 %indvar.next124.1, i64 0
  %scevgep125126.2 = bitcast i32* %scevgep125.2 to i8*
  %scevgep127.2 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvar.next124.1, i64 0
  %scevgep127128.2 = bitcast i32* %scevgep127.2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 dereferenceable(480) %scevgep125126.2, i8* nonnull align 4 dereferenceable(480) %scevgep127128.2, i64 480, i1 false)
  %indvar.next124.2 = add nuw nsw i64 %indvar123, 3
  %exitcond129.2 = icmp eq i64 %indvar.next124.2, 120
  br i1 %exitcond129.2, label %for.cond15.preheader, label %for.cond1.preheader

for.cond15.preheader:                             ; preds = %for.cond1.preheader
  %arraydecay = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 0
  br label %for.cond20.preheader

for.cond20.preheader:                             ; preds = %for.cond.cleanup22, %for.cond15.preheader
  %indvars.iv117 = phi i64 [ 0, %for.cond15.preheader ], [ %indvars.iv.next118, %for.cond.cleanup22 ]
  %1 = trunc i64 %indvars.iv117 to i32
  br label %for.body23

for.cond.cleanup22:                               ; preds = %if.end43
  %indvars.iv.next118 = add nuw nsw i64 %indvars.iv117, 1
  %exitcond119 = icmp eq i64 %indvars.iv.next118, 120
  br i1 %exitcond119, label %for.cond56.preheader, label %for.cond20.preheader

for.body23:                                       ; preds = %if.end43, %for.cond20.preheader
  %indvars.iv = phi i64 [ 0, %for.cond20.preheader ], [ %indvars.iv.next, %if.end43 ]
  %2 = trunc i64 %indvars.iv to i32
  %call = tail call i32 @CountAliveNeighbors([120 x i32]* %arraydecay, i32 %1, i32 %2)
  %arrayidx27 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvars.iv117, i64 %indvars.iv
  %3 = load i32, i32* %arrayidx27, align 4, !tbaa !2
  %cmp28 = icmp eq i32 %3, 1
  br i1 %cmp28, label %if.then, label %if.else

if.then:                                          ; preds = %for.body23
  %4 = and i32 %call, -2
  %5 = icmp eq i32 %4, 2
  br i1 %5, label %if.end43, label %if.then31

if.then31:                                        ; preds = %if.then
  %arrayidx35 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid, i64 0, i64 %indvars.iv117, i64 %indvars.iv
  store i32 0, i32* %arrayidx35, align 4, !tbaa !2
  br label %if.end43

if.else:                                          ; preds = %for.body23
  %cmp36 = icmp eq i32 %call, 3
  br i1 %cmp36, label %if.then37, label %if.end43

if.then37:                                        ; preds = %if.else
  %arrayidx41 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid, i64 0, i64 %indvars.iv117, i64 %indvars.iv
  store i32 1, i32* %arrayidx41, align 4, !tbaa !2
  br label %if.end43

if.end43:                                         ; preds = %if.then, %if.else, %if.then37, %if.then31
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond116 = icmp eq i64 %indvars.iv.next, 120
  br i1 %exitcond116, label %for.cond.cleanup22, label %for.body23

for.cond56.preheader:                             ; preds = %for.cond.cleanup22, %for.cond56.preheader
  %indvar = phi i64 [ %indvar.next.2, %for.cond56.preheader ], [ 0, %for.cond.cleanup22 ]
  %scevgep = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvar, i64 0
  %scevgep113 = bitcast i32* %scevgep to i8*
  %scevgep114 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid, i64 0, i64 %indvar, i64 0
  %scevgep114115 = bitcast i32* %scevgep114 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(480) %scevgep113, i8* nonnull align 16 dereferenceable(480) %scevgep114115, i64 480, i1 false)
  %indvar.next = add nuw nsw i64 %indvar, 1
  %scevgep.1 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvar.next, i64 0
  %scevgep113.1 = bitcast i32* %scevgep.1 to i8*
  %scevgep114.1 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid, i64 0, i64 %indvar.next, i64 0
  %scevgep114115.1 = bitcast i32* %scevgep114.1 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(480) %scevgep113.1, i8* nonnull align 16 dereferenceable(480) %scevgep114115.1, i64 480, i1 false)
  %indvar.next.1 = add nuw nsw i64 %indvar, 2
  %scevgep.2 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvar.next.1, i64 0
  %scevgep113.2 = bitcast i32* %scevgep.2 to i8*
  %scevgep114.2 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid, i64 0, i64 %indvar.next.1, i64 0
  %scevgep114115.2 = bitcast i32* %scevgep114.2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(480) %scevgep113.2, i8* nonnull align 16 dereferenceable(480) %scevgep114115.2, i64 480, i1 false)
  %indvar.next.2 = add nuw nsw i64 %indvar, 3
  %exitcond.2 = icmp eq i64 %indvar.next.2, 120
  br i1 %exitcond.2, label %for.cond.cleanup53, label %for.cond56.preheader

for.cond.cleanup53:                               ; preds = %for.cond56.preheader
  call void @llvm.lifetime.end.p0i8(i64 57600, i8* nonnull %0) #5
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local void @DrawGrid([120 x i32]* nocapture readonly %grid) local_unnamed_addr #0 {
entry:
  br label %for.cond1.preheader

for.cond1.preheader:                              ; preds = %for.cond.cleanup3, %entry
  %indvars.iv20 = phi i64 [ 0, %entry ], [ %indvars.iv.next21, %for.cond.cleanup3 ]
  %0 = trunc i64 %indvars.iv20 to i32
  br label %for.body4

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3
  ret void

for.cond.cleanup3:                                ; preds = %for.body4
  %indvars.iv.next21 = add nuw nsw i64 %indvars.iv20, 1
  %exitcond22 = icmp eq i64 %indvars.iv.next21, 120
  br i1 %exitcond22, label %for.cond.cleanup, label %for.cond1.preheader

for.body4:                                        ; preds = %for.body4, %for.cond1.preheader
  %indvars.iv = phi i64 [ 0, %for.cond1.preheader ], [ %indvars.iv.next, %for.body4 ]
  %arrayidx6 = getelementptr inbounds [120 x i32], [120 x i32]* %grid, i64 %indvars.iv20, i64 %indvars.iv
  %1 = load i32, i32* %arrayidx6, align 4, !tbaa !2
  %2 = trunc i64 %indvars.iv to i32
  tail call void @Lib_DrawCell(i32 %0, i32 %2, i32 %1) #5
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 120
  br i1 %exitcond, label %for.cond.cleanup3, label %for.body4
}

declare dso_local void @Lib_DrawCell(i32, i32, i32) local_unnamed_addr #2

; Function Attrs: noreturn nounwind uwtable
define dso_local void @app() local_unnamed_addr #4 {
entry:
  %newGrid.i = alloca [120 x [120 x i32]], align 16
  %grid = alloca [120 x [120 x i32]], align 16
  %0 = bitcast [120 x [120 x i32]]* %grid to i8*
  call void @llvm.lifetime.start.p0i8(i64 57600, i8* nonnull %0) #5
  call void @llvm.memset.p0i8.i64(i8* nonnull align 16 dereferenceable(57600) %0, i8 0, i64 57600, i1 false)
  %arraydecay = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 0
  %call.i = tail call i32 @Lib_Rand(i32 1000, i32 2000) #5
  %cmp10.i = icmp sgt i32 %call.i, 0
  br i1 %cmp10.i, label %for.body.i, label %InitGrid.exit

for.body.i:                                       ; preds = %entry, %for.body.i
  %i.011.i = phi i32 [ %inc.i, %for.body.i ], [ 0, %entry ]
  %call1.i = tail call i32 @Lib_Rand(i32 0, i32 119) #5
  %call2.i = tail call i32 @Lib_Rand(i32 0, i32 119) #5
  %idxprom.i = sext i32 %call2.i to i64
  %idxprom3.i = sext i32 %call1.i to i64
  %arrayidx4.i = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %idxprom.i, i64 %idxprom3.i
  store i32 1, i32* %arrayidx4.i, align 4, !tbaa !2
  %inc.i = add nuw nsw i32 %i.011.i, 1
  %exitcond.i = icmp eq i32 %inc.i, %call.i
  br i1 %exitcond.i, label %InitGrid.exit, label %for.body.i

InitGrid.exit:                                    ; preds = %for.body.i, %entry
  %1 = bitcast [120 x [120 x i32]]* %newGrid.i to i8*
  br label %while.cond

while.cond:                                       ; preds = %DrawGrid.exit, %InitGrid.exit
  call void @llvm.lifetime.start.p0i8(i64 57600, i8* nonnull %1) #5
  br label %for.cond1.preheader.i

for.cond1.preheader.i:                            ; preds = %for.cond1.preheader.i, %while.cond
  %indvar123.i = phi i64 [ 0, %while.cond ], [ %indvar.next124.i.2, %for.cond1.preheader.i ]
  %scevgep125.i = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid.i, i64 0, i64 %indvar123.i, i64 0
  %scevgep125126.i = bitcast i32* %scevgep125.i to i8*
  %scevgep127.i = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvar123.i, i64 0
  %scevgep127128.i = bitcast i32* %scevgep127.i to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 dereferenceable(480) %scevgep125126.i, i8* nonnull align 16 dereferenceable(480) %scevgep127128.i, i64 480, i1 false) #5
  %indvar.next124.i = add nuw nsw i64 %indvar123.i, 1
  %scevgep125.i.1 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid.i, i64 0, i64 %indvar.next124.i, i64 0
  %scevgep125126.i.1 = bitcast i32* %scevgep125.i.1 to i8*
  %scevgep127.i.1 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvar.next124.i, i64 0
  %scevgep127128.i.1 = bitcast i32* %scevgep127.i.1 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 dereferenceable(480) %scevgep125126.i.1, i8* nonnull align 16 dereferenceable(480) %scevgep127128.i.1, i64 480, i1 false) #5
  %indvar.next124.i.1 = add nuw nsw i64 %indvar123.i, 2
  %scevgep125.i.2 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid.i, i64 0, i64 %indvar.next124.i.1, i64 0
  %scevgep125126.i.2 = bitcast i32* %scevgep125.i.2 to i8*
  %scevgep127.i.2 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvar.next124.i.1, i64 0
  %scevgep127128.i.2 = bitcast i32* %scevgep127.i.2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 dereferenceable(480) %scevgep125126.i.2, i8* nonnull align 16 dereferenceable(480) %scevgep127128.i.2, i64 480, i1 false) #5
  %indvar.next124.i.2 = add nuw nsw i64 %indvar123.i, 3
  %exitcond129.i.2 = icmp eq i64 %indvar.next124.i.2, 120
  br i1 %exitcond129.i.2, label %for.cond20.preheader.i, label %for.cond1.preheader.i

for.cond20.preheader.i:                           ; preds = %for.cond1.preheader.i, %for.cond.cleanup22.i
  %indvars.iv117.i = phi i64 [ %indvars.iv.next118.i, %for.cond.cleanup22.i ], [ 0, %for.cond1.preheader.i ]
  %2 = trunc i64 %indvars.iv117.i to i32
  br label %for.body23.i

for.cond.cleanup22.i:                             ; preds = %if.end43.i
  %indvars.iv.next118.i = add nuw nsw i64 %indvars.iv117.i, 1
  %exitcond119.i = icmp eq i64 %indvars.iv.next118.i, 120
  br i1 %exitcond119.i, label %for.cond56.preheader.i, label %for.cond20.preheader.i

for.body23.i:                                     ; preds = %if.end43.i, %for.cond20.preheader.i
  %indvars.iv.i = phi i64 [ 0, %for.cond20.preheader.i ], [ %indvars.iv.next.i, %if.end43.i ]
  %3 = trunc i64 %indvars.iv.i to i32
  %call.i2 = call i32 @CountAliveNeighbors([120 x i32]* nonnull %arraydecay, i32 %2, i32 %3) #5
  %arrayidx27.i = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvars.iv117.i, i64 %indvars.iv.i
  %4 = load i32, i32* %arrayidx27.i, align 4, !tbaa !2
  %cmp28.i = icmp eq i32 %4, 1
  br i1 %cmp28.i, label %if.then.i, label %if.else.i

if.then.i:                                        ; preds = %for.body23.i
  %5 = and i32 %call.i2, -2
  %6 = icmp eq i32 %5, 2
  br i1 %6, label %if.end43.i, label %if.then31.i

if.then31.i:                                      ; preds = %if.then.i
  %arrayidx35.i = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid.i, i64 0, i64 %indvars.iv117.i, i64 %indvars.iv.i
  store i32 0, i32* %arrayidx35.i, align 4, !tbaa !2
  br label %if.end43.i

if.else.i:                                        ; preds = %for.body23.i
  %cmp36.i = icmp eq i32 %call.i2, 3
  br i1 %cmp36.i, label %if.then37.i, label %if.end43.i

if.then37.i:                                      ; preds = %if.else.i
  %arrayidx41.i = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid.i, i64 0, i64 %indvars.iv117.i, i64 %indvars.iv.i
  store i32 1, i32* %arrayidx41.i, align 4, !tbaa !2
  br label %if.end43.i

if.end43.i:                                       ; preds = %if.then37.i, %if.else.i, %if.then31.i, %if.then.i
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i, 1
  %exitcond116.i = icmp eq i64 %indvars.iv.next.i, 120
  br i1 %exitcond116.i, label %for.cond.cleanup22.i, label %for.body23.i

for.cond56.preheader.i:                           ; preds = %for.cond.cleanup22.i, %for.cond56.preheader.i
  %indvar.i = phi i64 [ %indvar.next.i.2, %for.cond56.preheader.i ], [ 0, %for.cond.cleanup22.i ]
  %scevgep.i = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvar.i, i64 0
  %scevgep113.i = bitcast i32* %scevgep.i to i8*
  %scevgep114.i = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid.i, i64 0, i64 %indvar.i, i64 0
  %scevgep114115.i = bitcast i32* %scevgep114.i to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 dereferenceable(480) %scevgep113.i, i8* nonnull align 16 dereferenceable(480) %scevgep114115.i, i64 480, i1 false) #5
  %indvar.next.i = add nuw nsw i64 %indvar.i, 1
  %scevgep.i.1 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvar.next.i, i64 0
  %scevgep113.i.1 = bitcast i32* %scevgep.i.1 to i8*
  %scevgep114.i.1 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid.i, i64 0, i64 %indvar.next.i, i64 0
  %scevgep114115.i.1 = bitcast i32* %scevgep114.i.1 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 dereferenceable(480) %scevgep113.i.1, i8* nonnull align 16 dereferenceable(480) %scevgep114115.i.1, i64 480, i1 false) #5
  %indvar.next.i.1 = add nuw nsw i64 %indvar.i, 2
  %scevgep.i.2 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvar.next.i.1, i64 0
  %scevgep113.i.2 = bitcast i32* %scevgep.i.2 to i8*
  %scevgep114.i.2 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid.i, i64 0, i64 %indvar.next.i.1, i64 0
  %scevgep114115.i.2 = bitcast i32* %scevgep114.i.2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 dereferenceable(480) %scevgep113.i.2, i8* nonnull align 16 dereferenceable(480) %scevgep114115.i.2, i64 480, i1 false) #5
  %indvar.next.i.2 = add nuw nsw i64 %indvar.i, 3
  %exitcond.i3.2 = icmp eq i64 %indvar.next.i.2, 120
  br i1 %exitcond.i3.2, label %UpdateGrid.exit, label %for.cond56.preheader.i

UpdateGrid.exit:                                  ; preds = %for.cond56.preheader.i
  call void @llvm.lifetime.end.p0i8(i64 57600, i8* nonnull %1) #5
  br label %for.cond1.preheader.i4

for.cond1.preheader.i4:                           ; preds = %for.cond.cleanup3.i, %UpdateGrid.exit
  %indvars.iv20.i = phi i64 [ 0, %UpdateGrid.exit ], [ %indvars.iv.next21.i, %for.cond.cleanup3.i ]
  %7 = trunc i64 %indvars.iv20.i to i32
  br label %for.body4.i

for.cond.cleanup3.i:                              ; preds = %for.body4.i
  %indvars.iv.next21.i = add nuw nsw i64 %indvars.iv20.i, 1
  %exitcond22.i = icmp eq i64 %indvars.iv.next21.i, 120
  br i1 %exitcond22.i, label %DrawGrid.exit, label %for.cond1.preheader.i4

for.body4.i:                                      ; preds = %for.body4.i, %for.cond1.preheader.i4
  %indvars.iv.i5 = phi i64 [ 0, %for.cond1.preheader.i4 ], [ %indvars.iv.next.i6, %for.body4.i ]
  %arrayidx6.i = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 %indvars.iv20.i, i64 %indvars.iv.i5
  %8 = load i32, i32* %arrayidx6.i, align 4, !tbaa !2
  %9 = trunc i64 %indvars.iv.i5 to i32
  tail call void @Lib_DrawCell(i32 %7, i32 %9, i32 %8) #5
  %indvars.iv.next.i6 = add nuw nsw i64 %indvars.iv.i5, 1
  %exitcond.i7 = icmp eq i64 %indvars.iv.next.i6, 120
  br i1 %exitcond.i7, label %for.cond.cleanup3.i, label %for.body4.i

DrawGrid.exit:                                    ; preds = %for.cond.cleanup3.i
  tail call void (...) @Lib_Display() #5
  br label %while.cond
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #1

declare dso_local void @Lib_Display(...) local_unnamed_addr #2

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { norecurse nounwind readonly uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1 "}
!2 = !{!3, !3, i64 0}
!3 = !{!"int", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
