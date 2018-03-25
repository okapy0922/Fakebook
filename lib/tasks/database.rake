require 'active_record/connection_adapters/postgresql_adapter'
module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLAdapter < AbstractAdapter
      def drop_database(name)
        raise "I won't drop the production database" if Rails.env.production?
        execute <<-SQL
        UPDATE pg_catalog.pg_database
        SET datallowconn=false WHERE datname='#{fakebook_production}'
        SQL

        execute <<-SQL
        SELECT pg_terminate_backend(pg_stat_activity.pid)
        FROM pg_stat_activity
        WHERE pg_stat_activity.datname = '#{fakebook_production}';
        SQL
        execute "DROP DATABASE IF EXISTS #{quote_table_name(fakebook_production)}"
      end
    end
  end
end
