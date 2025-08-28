import { createClient } from '@supabase/supabase-js';

// Environment variables are injected by Netlify during build
const supabaseUrl = import.meta.env.SUPABASE_URL || '';
const supabaseKey = import.meta.env.SUPABASE_KEY || '';

if (!supabaseUrl || !supabaseKey) {
    console.warn('Supabase credentials not found. Make sure you have SUPABASE_URL and SUPABASE_KEY set in your environment variables.');
}

export const supabase = createClient(supabaseUrl, supabaseKey);

export interface Ranking {
    id: number;
    category: string;
    name: string;
    votes: number;
    image_url?: string;
    description?: string;
    created_at?: string;
}

// Helper function to fetch rankings for a specific category
export async function getRankings(category: string): Promise<Ranking[]> {
    const { data, error } = await supabase
        .from('rankings')
        .select('*')
        .eq('category', category)
        .order('votes', { ascending: false });

    if (error) {
        console.error('Error fetching rankings:', error);
        return [];
    }

    return data || [];
}

// Helper function to upvote an item
export async function upvoteItem(id: number): Promise<boolean> {
    const { error } = await supabase.rpc('increment_votes', { item_id: id });

    if (error) {
        console.error('Error upvoting item:', error);
        return false;
    }

    return true;
}