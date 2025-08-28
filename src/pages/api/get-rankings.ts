import { getRankings } from '../../lib/fileStorage';
import type { APIRoute } from 'astro';

export const GET: APIRoute = async ({ params, request }) => {
    try {
        // Get the category from URL query parameters
        const url = new URL(request.url);
        const category = url.searchParams.get('category');

        if (!category) {
            return new Response(
                JSON.stringify({
                    error: 'Category parameter is required'
                }),
                {
                    status: 400,
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }
            );
        }

        const rankings = await getRankings(category);

        return new Response(
            JSON.stringify(rankings),
            {
                status: 200,
                headers: {
                    'Content-Type': 'application/json'
                }
            }
        );
    } catch (error) {
        console.error('Error in get-rankings endpoint:', error);
        return new Response(
            JSON.stringify({
                error: 'Failed to fetch rankings'
            }),
            {
                status: 500,
                headers: {
                    'Content-Type': 'application/json'
                }
            }
        );
    }
}