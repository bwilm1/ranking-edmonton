import { upvoteItem } from '../../lib/fileStorage';
import type { APIRoute } from 'astro';

export const POST: APIRoute = async ({ request }) => {
    try {
        // Parse the request body to get the item ID
        const body = await request.json();
        const { id } = body;

        if (!id || typeof id !== 'number') {
            return new Response(
                JSON.stringify({
                    error: 'Valid item ID is required'
                }),
                {
                    status: 400,
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }
            );
        }

        const success = await upvoteItem(id);

        if (!success) {
            return new Response(
                JSON.stringify({
                    error: 'Failed to upvote item'
                }),
                {
                    status: 500,
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }
            );
        }

        return new Response(
            JSON.stringify({ success: true }),
            {
                status: 200,
                headers: {
                    'Content-Type': 'application/json'
                }
            }
        );
    } catch (error) {
        console.error('Error in vote endpoint:', error);
        return new Response(
            JSON.stringify({
                error: 'Failed to process vote'
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