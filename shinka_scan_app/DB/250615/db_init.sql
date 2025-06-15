-- Function to automatically update the updated_at timestamp
CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW(); -- Set updated_at to the current timestamp
  RETURN NEW; -- Return the modified row
END;
$$ LANGUAGE plpgsql;

-- Table to store individual card details
CREATE TABLE IF NOT EXISTS cards (
    -- Use GENERATED ALWAYS AS IDENTITY for auto-incrementing primary key (SQL standard)
    -- Alternatively, you could use SERIAL PRIMARY KEY
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cardno VARCHAR(20) NOT NULL,          -- e.g., BP01-001
    expansion VARCHAR(10) NOT NULL,       -- e.g., BP01
    japanese_name VARCHAR(255),
    image_url VARCHAR(512),
    detail_page_url VARCHAR(512),
    japanese_set_name VARCHAR(255),
    card_class VARCHAR(50),               -- e.g., エルフ (Elf)
    card_type VARCHAR(50),                -- e.g., フォロワー (Follower)
    card_subtype VARCHAR(100),            -- e.g., 兵士 (Officer) - Can be NULL or multiple
    rarity VARCHAR(10),                   -- e.g., LG, GR, SR, BR
    cost INT,                             -- Card cost
    attack INT,                           -- Attack stat (nullable)
    defense INT,                          -- Defense stat (nullable)
    card_text TEXT,                       -- Full card text including effects
    illustrator VARCHAR(255),
    last_scraped_details_at TIMESTAMP,    -- To track when details were last fetched (NULL is default)
    -- Default timestamp for creation
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- Default timestamp for update (will be automatically updated by trigger)
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- Ensure each card per set is unique using a named constraint
    CONSTRAINT unique_card UNIQUE (expansion, cardno)
);

-- Trigger to automatically update the updated_at column on row update
-- Drop trigger first if it exists to make the script idempotent
DROP TRIGGER IF EXISTS set_timestamp ON cards;
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON cards -- Trigger fires before an UPDATE operation
FOR EACH ROW -- Trigger fires for each row affected
EXECUTE FUNCTION trigger_set_timestamp(); -- Call the function defined above

-- Junction table for many-to-many card relationships
CREATE TABLE IF NOT EXISTS card_relationships (
    source_card_id INT NOT NULL,
    related_card_id INT NOT NULL,
    -- Define primary key constraint
    PRIMARY KEY (source_card_id, related_card_id),
    -- Define foreign key constraints referencing the cards table
    -- ON DELETE CASCADE ensures relationship rows are deleted if the referenced card is deleted
    FOREIGN KEY (source_card_id) REFERENCES cards(id) ON DELETE CASCADE,
    FOREIGN KEY (related_card_id) REFERENCES cards(id) ON DELETE CASCADE
);

-- Optional: Add comments to tables and columns for better documentation (Example)
COMMENT ON TABLE cards IS 'Stores detailed information about individual Shadowverse Evolve cards.';
COMMENT ON COLUMN cards.last_scraped_details_at IS 'Timestamp of the last successful scrape of the card detail page.';
COMMENT ON TABLE card_relationships IS 'Stores many-to-many relationships between cards (e.g., tokens, related transformations).';

