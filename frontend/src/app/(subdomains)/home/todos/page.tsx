import { createClient } from '@/utils/supabase/server'
import { cookies, headers } from 'next/headers'

export default async function Page() {
  const cookieStore = await cookies()
  const headersList = await headers()
  const host = headersList.get('host') || 'velsec.local'
  const supabase = createClient(cookieStore, host)

  // Fetch todos (fails gracefully if table is not configured)
  const { data: todos } = await supabase.from('todos').select()

  return (
    <main className="min-h-screen bg-[#050a18] pt-28 pb-12 px-6 flex flex-col items-center justify-center font-mono">
      <div className="w-full max-w-md border border-[#0096ff]/20 bg-[#0a1432]/30 backdrop-blur-md p-8 rounded-2xl flex flex-col gap-6 shadow-[0_0_30px_rgba(0,150,255,0.08)]">
        <h1 className="text-xl font-bold tracking-widest text-zinc-100 border-b border-[#0096ff]/10 pb-3 uppercase">
          Todos<span className="text-[#0096ff]">_List</span>
        </h1>
        
        {todos && todos.length > 0 ? (
          <ul className="space-y-2 text-sm text-zinc-300">
            {todos.map((todo: any) => (
              <li key={todo.id} className="flex items-center gap-2 px-3 py-2 rounded border border-[#0a1a40] bg-[#050a18]/60">
                <span className="text-[#0096ff]">✔</span>
                <span>{todo.name}</span>
              </li>
            ))}
          </ul>
        ) : (
          <div className="text-center py-6 border border-dashed border-[#0a1a40] rounded-lg text-zinc-500 text-xs">
            NO_ENTRIES_AVAILABLE
          </div>
        )}

        <div className="text-center mt-2">
          <a href="/" className="text-xs text-zinc-500 hover:text-[#0096ff] transition-colors">
            &lt;-- BACK_HOME
          </a>
        </div>
      </div>
    </main>
  )
}
