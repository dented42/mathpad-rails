class MoveLinesIntoScratchpads < ActiveRecord::Migration
  def change

    add_column :scratchpads, :lines, :text, array: true, null: false, default: []

    reversible do |dir|
      dir.up do
        execute <<-SQL
          DO $$
          DECLARE
            pad_id integer;
            line_array text[];
          BEGIN
            FOR pad_id IN
              SELECT id
              FROM scratchpads
            LOOP
              line_array := array(SELECT content
                                  FROM lines
                                  WHERE scratchpad_id = pad_id
                                  ORDER BY "order" ASC);
              UPDATE scratchpads
              SET lines = line_array
              WHERE id = pad_id;
            END LOOP;
          END
          $$;
        SQL
      end
      dir.down do
        execute <<-SQL
        DO $$
        DECLARE
          pad_id integer;
          line_array text[];
          line text;
          i integer;
        BEGIN
          FOR pad_id IN
            SELECT id
            FROM scratchpads
          LOOP
  
            SELECT lines
            INTO STRICT line_array
            FROM scratchpads
            WHERE id = pad_id;

            FOR i IN
              1 .. array_upper(line_array, 1)
            LOOP

              INSERT INTO lines (scratchpad_id,
                                 "order",
                                 content,
                                 created_at,
                                 updated_at)
              VALUES (pad_id,
                      i,
                      line_array[i],
                      current_timestamp,
                      current_timestamp);
            END LOOP;
          END LOOP;
        END
        $$
        SQL
      end
    end

    drop_table :lines do |t|
      t.references :scratchpad, null: false, foreign_key: true
      t.integer :order, null: false

      t.index [:scratchpad_id, :order], unique: true
      
      t.text :content, null: false

      t.timestamps null: false
    end
    
  end
end
