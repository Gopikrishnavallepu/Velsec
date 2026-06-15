import React from 'react';

interface LearningGoalCardProps {
  goal: string;
  certificationName: string;
  progressPercent: number;
}

export default function LearningGoalCard({ goal, certificationName, progressPercent }: LearningGoalCardProps) {
  return (
    <div className="relative border border-secondary/15 bg-card/25 backdrop-blur-md rounded-xl p-5 lg:col-span-1 flex flex-col justify-between overflow-hidden">
      <div className="absolute bottom-0 right-0 w-1.5 h-1.5 border-b border-r border-secondary/40" />
      {/* Ambient glow */}
      <div className="absolute -top-20 -right-20 w-48 h-48 bg-secondary/10 blur-[50px] rounded-full pointer-events-none" />
      
      <div>
        <h2 className="text-lg font-bold font-mono text-secondary mb-4 border-b border-secondary/10 pb-2">
          {"//"} ULTIMATE_GOAL
        </h2>
        <div className="p-4 bg-secondary/5 border border-secondary/20 rounded-lg">
          <p className="text-xs font-mono leading-relaxed text-foreground">
            {goal}
          </p>
        </div>
      </div>

      <div className="mt-6">
        <h2 className="text-lg font-bold font-mono text-secondary mb-4 border-b border-secondary/10 pb-2">
          {"//"} FINAL_OUTPUT
        </h2>
        <div className="flex items-center gap-4">
          <div className="w-12 h-12 rounded-full border-2 border-secondary flex items-center justify-center shadow-[0_0_15px_rgba(0,150,255,0.4)]">
            <span className="text-xl">🏆</span>
          </div>
          <div className="flex-1">
            <p className="text-xs font-bold font-mono text-foreground mb-1">{certificationName}</p>
            <div className="w-full h-1.5 bg-background rounded-full overflow-hidden border border-secondary/20">
              <div 
                className="h-full bg-gradient-to-r from-secondary/40 to-secondary transition-all duration-1000" 
                style={{ width: `${progressPercent}%` }}
              />
            </div>
            <p className="text-[9px] font-mono text-muted-foreground mt-1 text-right">{progressPercent}% IN_PROGRESS</p>
          </div>
        </div>
      </div>
    </div>
  );
}
