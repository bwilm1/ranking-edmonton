import { promises as fs } from 'fs';
import path from 'path';

export interface Ranking {
    id: number;
    category: string;
    name: string;
    votes: number;
    image_url: string;
    description: string;
}

// Path to our JSON data file - works in both dev and production with Netlify functions
const getDataPath = () => {
    // In Netlify Functions, process.env.NETLIFY is set to 'true'
    if (process.env.NETLIFY) {
        return path.join(process.cwd(), 'src', 'data', 'rankings.json');
    }
    // In local development
    return path.join(process.cwd(), 'src', 'data', 'rankings.json');
};

// Get all rankings for a specific category
export async function getRankings(category: string): Promise<Ranking[]> {
    try {
        const dataPath = getDataPath();
        const data = await fs.readFile(dataPath, 'utf-8');
        const allRankings = JSON.parse(data);

        if (!allRankings[category]) {
            return [];
        }

        return allRankings[category].sort((a: Ranking, b: Ranking) => b.votes - a.votes);
    } catch (error) {
        console.error('Error reading rankings:', error);
        return [];
    }
}

// Upvote an item
export async function upvoteItem(itemId: number): Promise<boolean> {
    try {
        const dataPath = getDataPath();
        const data = await fs.readFile(dataPath, 'utf-8');
        const allRankings = JSON.parse(data);

        // Find the item across all categories
        let found = false;

        for (const category of Object.keys(allRankings)) {
            const items = allRankings[category];
            const itemIndex = items.findIndex((item: Ranking) => item.id === itemId);

            if (itemIndex !== -1) {
                // Increment the votes
                allRankings[category][itemIndex].votes += 1;
                found = true;
                break;
            }
        }

        if (!found) {
            return false;
        }

        // Write the updated data back to the file
        await fs.writeFile(dataPath, JSON.stringify(allRankings, null, 2), 'utf-8');
        return true;
    } catch (error) {
        console.error('Error upvoting item:', error);
        return false;
    }
}