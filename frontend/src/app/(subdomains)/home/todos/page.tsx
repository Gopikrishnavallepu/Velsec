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
    <main className="min-h-screen bg-background pt-28 pb-12 px-6 flex flex-col items-center justify-center font-mono">
      <div className="w-full max-w-md border border-secondary/20 bg-card/30 backdrop-blur-md p-8 rounded-2xl flex flex-col gap-6 shadow-[0_0_30px_rgba(0,150,255,0.08)]">
        <h1 className="text-xl font-bold tracking-widest text-foreground border-b border-secondary/10 pb-3 uppercase">
          Todos<span className="text-secondary">_List</span>
        </h1>
        
        {todos && todos.length > 0 ? (
          <ul className="space-y-2 text-sm text-foreground">
            {todos.map((todo: any) => (
              <li key={todo.id} className="flex items-center gap-2 px-3 py-2 rounded border border-border bg-background/60">
                <span className="text-secondary">✔</span>
                <span>{todo.name}</span>
              </li>
            ))}
          </ul>
        ) : (
          <div className="text-center py-6 border border-dashed border-border rounded-lg text-muted-foreground text-xs">
            NO_ENTRIES_AVAILABLE
          </div>
        )}

        <div className="text-center mt-2">
          <a href="/" className="text-xs text-muted-foreground hover:text-secondary transition-colors">
            &lt;-- BACK_HOME
          </a>
        </div>
      </div>
    </main>
  )
}
