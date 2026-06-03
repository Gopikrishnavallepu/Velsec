'use client';

import { useState, useEffect } from 'react';
import ParticleField from '@/components/ui/ParticleField';
import { getSubdomainUrl } from '@/utils/navigation';

interface Project {
  id: string;
  name: string;
  category: string;
  status: 'passed' | 'failed' | 'idle';
  vulnerabilities: number;
  stages: string[];
}

const projectsData: Project[] = [
  {
    id: 'terraform-aws',
    name: 'Secure AWS Infrastructure (Terraform)',
    category: 'Infrastructure as Code',
    status: 'passed',
    vulnerabilities: 0,
    stages: ['Plan', 'tfsec Scan', 'Infracost Check', 'Deploy'],
  },
  {
    id: 'docker-hardening',
    name: 'Hardened Alpine/Docker Images',
    category: 'Containerization',
    status: 'failed',
    vulnerabilities: 3,
    stages: ['Linter', 'Trivy Scan', 'Docker Build', 'Sign Image'],
  },
  {
    id: 'k8s-hardening',
    name: 'Kubernetes Cluster Hardening',
    category: 'Orchestration',
    status: 'idle',
    vulnerabilities: 0,
    stages: ['kube-linter', 'Network Policy', 'OPA Gatekeeper', 'Verify'],
  },
  {
    id: 'sast-pipeline',
    name: 'GitHub Actions Node.js SAST Pipeline',
    category: 'CI/CD Pipelines',
    status: 'passed',
    vulnerabilities: 1,
    stages: ['Snyk Check', 'eslint-security', 'Build Bundle', 'Push Artefact'],
  },
];

export default function ProjectsPage() {
  const [mounted, setMounted] = useState(false);
  useEffect(() => {
    setMounted(true);
  }, []);

  const [selectedProject, setSelectedProject] = useState<Project>(projectsData[0]);
  const [pipelineState, setPipelineState] = useState<'idle' | 'running' | 'completed' | 'failed'>('idle');
  const [activeStageIndex, setActiveStageIndex] = useState<number>(-1);
  const [logs, setLogs] = useState<string[]>([]);

  useEffect(() => {
    // Reset pipeline state if user switches projects
    setPipelineState('idle');
    setActiveStageIndex(-1);
    setLogs([`[SYSTEM] Project "${selectedProject.name}" workspace loaded. Ready to execute pipeline.`]);
  }, [selectedProject]);

  const triggerPipeline = () => {
    if (pipelineState === 'running') return;
    
    setPipelineState('running');
    setActiveStageIndex(0);
    setLogs([`[PIPELINE] Initializing run for "${selectedProject.name}"...`]);

    const stages = selectedProject.stages;
    let currentStage = 0;

    const interval = setInterval(() => {
      if (currentStage < stages.length) {
        setLogs((prev) => [
          ...prev,
          `[STAGE] Running ${stages[currentStage]}...`,
          `[INFO] Checking policies, auditing config patterns.`,
          `[SUCCESS] ${stages[currentStage]} completed successfully.`,
        ]);
        currentStage++;
        setActiveStageIndex(currentStage);
      } else {
        clearInterval(interval);
        const endStatus = selectedProject.id === 'docker-hardening' ? 'failed' : 'completed';
        setPipelineState(endStatus);
        setActiveStageIndex(endStatus === 'failed' ? stages.length - 1 : stages.length);
        if (endStatus === 'failed') {
          setLogs((prev) => [
            ...prev,
            `[FATAL] Trivy Scan discovered 3 HIGH severity vulnerabilities in container base image!`,
            `[FATAL] Build aborted. Check Dockerfile base layers.`,
          ]);
        } else {
          setLogs((prev) => [
            ...prev,
            `[PIPELINE] All validation stages PASSED.`,
            `[SYSTEM] Release bundle ready for artifact store.`,
          ]);
        }
      }
    }, 1200);
  };

  return (
    <main className="relative min-h-screen overflow-x-hidden pt-24 pb-16 px-4 md:px-8 bg-[#050a18]">
      <ParticleField />
      
      {/* Background vignette overlay */}
      <div className="fixed inset-0 -z-5 pointer-events-none bg-gradient-to-t from-[#050a18] via-transparent to-[#050a18]/40" />

      <div className="z-10 max-w-6xl mx-auto flex flex-col gap-8">
        
        {/* Page Header */}
        <div className="relative border border-[#0096ff]/20 bg-[#0a1432]/30 backdrop-blur-md p-6 rounded-2xl flex flex-col md:flex-row md:items-center md:justify-between gap-4">
          <div className="absolute top-0 left-0 w-2 h-2 border-t-2 border-l-2 border-[#0096ff]" />
          <div className="absolute top-0 right-0 w-2 h-2 border-t-2 border-r-2 border-[#0096ff]" />
          <div className="absolute bottom-0 left-0 w-2 h-2 border-b-2 border-l-2 border-[#0096ff]" />
          <div className="absolute bottom-0 right-0 w-2 h-2 border-b-2 border-r-2 border-[#0096ff]" />
          
          <div>
            <div className="flex items-center gap-2 mb-1">
              <span className="w-2 h-2 bg-[#0096ff] rounded-full animate-ping" />
              <span className="text-[10px] font-mono text-[#0096ff] tracking-[0.3em] font-bold">V_LABS</span>
            </div>
            <h1 className="text-3xl font-extrabold font-mono tracking-wider">
              PROJECTS<span className="text-[#0096ff]">.VELSEC</span>
            </h1>
            <p className="text-xs text-zinc-400 font-mono mt-1">
              DevSecOps Sandboxes, Hardened Configurations &amp; Automated Security Audits
            </p>
          </div>

          <div className="flex gap-4 border-l border-[#0096ff]/15 pl-0 md:pl-6 pt-4 md:pt-0">
            <div className="text-center font-mono">
              <p className="text-[10px] text-zinc-500 font-bold">TEMPLATES</p>
              <p className="text-lg font-extrabold text-[#0096ff]">12</p>
            </div>
            <div className="text-center font-mono">
              <p className="text-[10px] text-zinc-500 font-bold">SECURE_LEVEL</p>
              <p className="text-lg font-extrabold text-[#0096ff]">98%</p>
            </div>
          </div>
        </div>

        {/* main workspace layout */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 items-stretch">
          
          {/* Workspace List Panel */}
          <div className="flex flex-col gap-4">
            <h2 className="text-xs font-mono font-bold tracking-widest text-[#0096ff]">// CHOOSE_WORKSPACE</h2>
            <div className="flex flex-col gap-3">
              {projectsData.map((p) => (
                <div
                  key={p.id}
                  onClick={() => setSelectedProject(p)}
                  className={`group relative p-4 rounded-xl border cursor-pointer transition-all duration-300 ${
                    selectedProject.id === p.id
                      ? 'border-[#0096ff] bg-[#0a1432]/30 shadow-[0_0_15px_rgba(0,150,255,0.08)]'
                      : 'border-[#0a1a40] hover:border-[#0096ff]/30 bg-[#0a1432]/5'
                  }`}
                >
                  <p className="text-[9px] font-mono text-zinc-500 tracking-wider mb-1">{p.category.toUpperCase()}</p>
                  <h3 className="text-xs font-bold font-mono text-zinc-200 group-hover:text-[#0096ff] transition-colors">{p.name}</h3>
                  <div className="flex justify-between items-center mt-3">
                    <span className={`text-[8px] font-mono font-bold px-1.5 py-0.5 rounded border ${
                      p.status === 'passed' ? 'border-emerald-500/25 bg-emerald-500/10 text-emerald-400' :
                      p.status === 'failed' ? 'border-rose-500/25 bg-rose-500/10 text-rose-400' :
                      'border-zinc-500/25 bg-zinc-500/10 text-zinc-400'
                    }`}>
                      {p.status.toUpperCase()}
                    </span>
                    <span className="text-[9px] font-mono text-zinc-500">
                      {p.vulnerabilities} VULNS
                    </span>
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* Interactive Pipeline Execution Terminal */}
          <div className="lg:col-span-2 flex flex-col gap-4">
            
            {/* Visualizer Panel */}
            <div className="relative border border-[#0096ff]/15 bg-[#0a1432]/25 backdrop-blur-md rounded-xl p-6 flex flex-col justify-between min-h-[300px]">
              <div className="absolute top-0 left-0 w-2 h-2 border-t-2 border-l-2 border-[#0096ff]/40" />
              <div className="absolute bottom-0 right-0 w-2 h-2 border-b-2 border-r-2 border-[#0096ff]/40" />
              
              <div className="flex justify-between items-center mb-6">
                <span className="text-[9px] font-mono text-[#0096ff] tracking-widest">// DEPLOYMENT_PIPELINE</span>
                <button
                  onClick={triggerPipeline}
                  disabled={pipelineState === 'running'}
                  className={`px-4 py-1.5 text-xs font-mono font-bold tracking-wider rounded-lg border transition-all duration-300 ${
                    pipelineState === 'running'
                      ? 'border-[#0a1a40] text-zinc-600 bg-transparent cursor-not-allowed'
                      : 'border-[#0096ff] text-[#0096ff] bg-[#0096ff]/5 hover:bg-[#0096ff]/20 shadow-[0_0_10px_rgba(0,150,255,0.15)] active:scale-98'
                  }`}
                >
                  {pipelineState === 'running' ? 'EXECUTING...' : 'TRIGGER_PIPELINE'}
                </button>
              </div>

              {/* Pipeline Nodes */}
              <div className="flex flex-col md:flex-row items-center justify-around gap-4 md:gap-2 my-auto">
                {selectedProject.stages.map((stage, idx) => {
                  let statusColor = 'border-[#0a1a40] text-zinc-500 bg-[#050a18]';
                  if (pipelineState === 'running') {
                    if (idx < activeStageIndex) {
                      statusColor = 'border-emerald-500 text-emerald-400 bg-emerald-500/5 shadow-[0_0_10px_rgba(16,185,129,0.15)]';
                    } else if (idx === activeStageIndex) {
                      statusColor = 'border-amber-500 text-amber-400 bg-amber-500/5 shadow-[0_0_10px_rgba(245,158,11,0.25)] animate-pulse';
                    }
                  } else if (pipelineState === 'completed') {
                    statusColor = 'border-emerald-500 text-emerald-400 bg-emerald-500/5';
                  } else if (pipelineState === 'failed') {
                    if (idx < selectedProject.stages.length - 1) {
                      statusColor = 'border-emerald-500 text-emerald-400 bg-emerald-500/5';
                    } else {
                      statusColor = 'border-rose-500 text-rose-400 bg-rose-500/5 shadow-[0_0_10px_rgba(239,68,68,0.25)]';
                    }
                  } else if (selectedProject.status === 'passed') {
                    statusColor = 'border-emerald-500/50 text-emerald-400/80 bg-[#050a18]';
                  } else if (selectedProject.status === 'failed') {
                    if (idx < selectedProject.stages.length - 1) {
                      statusColor = 'border-emerald-500/50 text-emerald-400/80 bg-[#050a18]';
                    } else {
                      statusColor = 'border-rose-500/50 text-rose-400/80 bg-[#050a18]';
                    }
                  }

                  return (
                    <div key={stage} className="flex flex-col md:flex-row items-center w-full md:w-auto">
                      <div className={`w-36 py-3 rounded-lg border text-center font-mono text-xs font-bold transition-all duration-500 ${statusColor}`}>
                        {stage}
                      </div>
                      {idx < selectedProject.stages.length - 1 && (
                        <div className="w-[2px] h-6 md:w-8 md:h-[2px] bg-gradient-to-r from-[#0096ff]/20 to-[#0096ff]/40 my-1 md:my-0" />
                      )}
                    </div>
                  );
                })}
              </div>

              {/* Logs output */}
              <div className="mt-8 bg-[#050a18]/90 rounded-lg border border-[#0a1a40] p-4 font-mono text-[10px] text-zinc-400 min-h-[120px] max-h-[180px] overflow-y-auto space-y-1">
                {logs.map((log, i) => (
                  <div
                    key={i}
                    className={
                      log.includes('[SUCCESS]') ? 'text-emerald-400' :
                      log.includes('[FATAL]') ? 'text-rose-400 font-bold' :
                      log.includes('[STAGE]') ? 'text-[#0096ff]' :
                      'text-zinc-500'
                    }
                  >
                    {log}
                  </div>
                ))}
              </div>

            </div>

          </div>

        </div>

        {/* Back Link */}
        <div className="text-center mt-4">
          <a
            href={mounted ? getSubdomainUrl('home') : '/'}
            className="inline-flex items-center gap-2 text-xs font-mono font-bold text-zinc-500 hover:text-[#0096ff] transition-colors"
          >
            <span>&lt;--</span>
            <span>SYSTEM_CORE_HOME</span>
          </a>
        </div>
      </div>
    </main>
  );
}
