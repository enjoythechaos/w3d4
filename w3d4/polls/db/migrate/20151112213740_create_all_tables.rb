class CreateAllTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.timestamps null: false
    end

    add_index(:users, :username, unique: true)

    create_table :polls do |t|
      t.string :title, null: false
      t.integer :author_id, null: false

      t.timestamps null: false
    end

    add_index(:polls, :author_id)

    create_table :questions do |t|
      t.string :text, null: false
      t.integer :poll_id, null: false

      t.timestamps null: false
    end

    add_index(:questions, :poll_id)

    create_table :answer_choices do |t|
      t.string :text, null: false
      t.integer :question_id, null: false

      t.timestamps null: false
    end

    add_index(:answer_choices, :question_id)

    create_table :responses do |t|
      t.integer :user_id, null: false
      t.integer :answer_choice_id, null: false

      t.timestamps null: false
    end

    add_index(:responses, :user_id)
    add_index(:responses, :answer_choice_id)

  end
end
