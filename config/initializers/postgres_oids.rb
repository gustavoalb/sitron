# -*- encoding : utf-8 -*-
ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.tap do |klass|
# Use identity which does no casting
klass::OID.register_type('geography', klass::OID::Identity.new)
klass::OID.register_type('time with time zone', klass::OID::Time.new)
ActiveRecord::ConnectionAdapters::PostgreSQLAdapter::OID.alias_type 'unknown', 'text'

end
