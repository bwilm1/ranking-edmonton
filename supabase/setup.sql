-- Create the rankings table
CREATE TABLE IF NOT EXISTS rankings (
  id SERIAL PRIMARY KEY,
  category TEXT NOT NULL,
  name TEXT NOT NULL,
  votes INTEGER NOT NULL DEFAULT 0,
  image_url TEXT,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_rankings_category ON rankings(category);
CREATE INDEX IF NOT EXISTS idx_rankings_votes ON rankings(votes);

-- Create a secure RPC function for incrementing votes
-- This prevents race conditions when multiple users vote at the same time
CREATE OR REPLACE FUNCTION increment_votes(item_id INT)
RETURNS VOID AS $$
BEGIN
  UPDATE rankings
  SET votes = votes + 1
  WHERE id = item_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Insert sample data for pizza category
INSERT INTO rankings (category, name, votes, image_url, description)
VALUES 
  ('pizza', 'Sepps Pizza', 32, '/images/pizza/sepps.jpg', 'Known for their authentic New York-style pizza with thin, foldable slices and a perfect balance of sauce and cheese. Their pepperoni pizza is a local favorite.'),
  ('pizza', 'Blaze Pizza', 28, '/images/pizza/blaze.jpg', 'Fast-fired custom pizzas with a wide variety of toppings. Great for those who want to customize their pizza exactly to their liking.'),
  ('pizza', 'Famoso Neapolitan Pizzeria', 25, '/images/pizza/famoso.jpg', 'Traditional Neapolitan pizzas cooked in a bell oven. Their Margherita pizza stays true to Italian roots with San Marzano tomatoes and fresh basil.'),
  ('pizza', 'Tony''s Pizza Palace', 22, '/images/pizza/tonys.jpg', 'Family-owned pizzeria serving traditional Italian pies since 1974. Known for their perfectly crispy yet chewy crust and generous toppings.'),
  ('pizza', 'Campio Brewing Co.', 18, '/images/pizza/campio.jpg', 'Craft brewery with exceptional sourdough pizzas. Their unique pizza creations pair perfectly with their house-brewed beers.');

-- Insert sample data for coffee category
INSERT INTO rankings (category, name, votes, image_url, description)
VALUES 
  ('coffee', 'Transcend Coffee', 45, '/images/coffee/transcend.jpg', 'Specialty coffee roaster known for direct trade relationships with coffee farmers. Their pour-over coffees highlight the unique characteristics of single-origin beans.'),
  ('coffee', 'ACE Coffee Roasters', 39, '/images/coffee/ace.jpg', 'Modern coffee shop with a minimalist aesthetic and expertly crafted espresso drinks. Their flat white is considered one of the best in the city.'),
  ('coffee', 'The Columbian Coffee House', 33, '/images/coffee/columbian.jpg', 'Cozy café with excellent Colombian beans and a welcoming atmosphere. Perfect for studying or catching up with friends.'),
  ('coffee', 'Remedy Café', 30, '/images/coffee/remedy.jpg', 'Eclectic café serving chai lattes and Indian-inspired food alongside great coffee. Multiple locations make it a convenient choice across the city.'),
  ('coffee', 'Lock Stock Coffee', 27, '/images/coffee/lockstock.jpg', 'Hip downtown coffee spot known for their artisanal approach to coffee and friendly baristas who remember regular customers'' orders.');

-- Insert sample data for gyms category
INSERT INTO rankings (category, name, votes, image_url, description)
VALUES 
  ('gyms', 'Evolve Strength', 37, '/images/gyms/evolve.jpg', 'Modern facility with top-of-the-line equipment, personal training, and group classes. Known for their welcoming atmosphere for both beginners and experienced lifters.'),
  ('gyms', 'SVPT Fitness', 32, '/images/gyms/svpt.jpg', 'Boutique personal training studio offering customized one-on-one coaching and small group training sessions. Great for those seeking personalized attention.'),
  ('gyms', 'Goodlife Fitness', 28, '/images/gyms/goodlife.jpg', 'National chain with multiple Edmonton locations, offering 24/7 access, diverse equipment, and a wide range of classes.'),
  ('gyms', 'YMCA', 23, '/images/gyms/ymca.jpg', 'Community-focused facilities with pools, basketball courts, and fitness classes. Family-friendly with programs for all ages.'),
  ('gyms', 'F45 Training', 19, '/images/gyms/f45.jpg', 'High-intensity functional training in a group setting. Their 45-minute workouts combine strength, cardio, and flexibility training.');

-- Insert sample data for neighborhoods category
INSERT INTO rankings (category, name, votes, image_url, description)
VALUES 
  ('neighborhoods', 'Old Strathcona', 42, '/images/neighborhoods/oldstrathcona.jpg', 'Historic district with charming character homes, boutique shopping, and vibrant nightlife. Home to the famous Whyte Avenue and close to the University of Alberta.'),
  ('neighborhoods', 'Glenora', 36, '/images/neighborhoods/glenora.jpg', 'Prestigious neighborhood with beautiful mature trees, historic homes, and proximity to the river valley. Known for excellent schools and quiet streets.'),
  ('neighborhoods', 'Downtown', 31, '/images/neighborhoods/downtown.jpg', 'Urban core with modern condos, access to the Arts District, and growing food scene. Perfect for professionals seeking a walkable lifestyle.'),
  ('neighborhoods', 'Ritchie', 28, '/images/neighborhoods/ritchie.jpg', 'Up-and-coming area with a mix of character homes and new developments. Great local businesses, breweries, and community spirit.'),
  ('neighborhoods', 'Highlands', 24, '/images/neighborhoods/highlands.jpg', 'Charming riverside community with historic homes, tree-lined streets, and a small-town feel despite being close to downtown.');

-- Insert sample data for festivals category
INSERT INTO rankings (category, name, votes, image_url, description)
VALUES 
  ('festivals', 'Edmonton Folk Music Festival', 51, '/images/festivals/folkfest.jpg', 'Beloved summer festival in Gallagher Park featuring local and international folk artists. Known for its relaxed atmosphere and stunning river valley views.'),
  ('festivals', 'K-Days', 44, '/images/festivals/kdays.jpg', 'Annual summer exhibition with midway rides, concerts, food, and exhibitions. A longstanding Edmonton tradition that attracts visitors of all ages.'),
  ('festivals', 'Taste of Edmonton', 39, '/images/festivals/taste.jpg', 'Food festival showcasing the diverse culinary scene of Edmonton. Features samples from dozens of local restaurants and food trucks.'),
  ('festivals', 'Edmonton International Fringe Theatre Festival', 35, '/images/festivals/fringe.jpg', 'North America''s largest fringe festival, featuring hundreds of independent theater performances throughout Old Strathcona.'),
  ('festivals', 'Heritage Festival', 30, '/images/festivals/heritage.jpg', 'Celebration of Edmonton''s cultural diversity, with pavilions representing over 100 countries. Features traditional food, dance, and crafts from around the world.');