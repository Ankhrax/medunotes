class CreateSolidQueueTables < ActiveRecord::Migration[8.0]
  def change
    create_table :solid_queue_jobs do |t|
      t.string :queue, null: false
      t.string :job_class, null: false
      t.jsonb :arguments, default: []
      t.datetime :scheduled_at
      t.datetime :started_at
      t.datetime :finished_at
      t.datetime :failed_at
      t.integer :attempts, default: 0, null: false
      t.string :status, null: false, default: "queued"
      t.timestamps
    end

    add_index :solid_queue_jobs, :queue
    add_index :solid_queue_jobs, :status
  end
end
