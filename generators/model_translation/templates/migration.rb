class <%= migration_name %> < ActiveRecord::Migration
  def self.up
    create_table :<%= table_name %>, :options => 'CHARSET=utf8' do |t|
      t.integer :record_id, :null => false
      t.integer :language_id, :null => false 
      
<% for attribute in attributes -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end -%>
    end

    add_index :<%= table_name %>, [:record_id, :language_id]
  end

  def self.down
    drop_table :<%= table_name %>
  end
end

