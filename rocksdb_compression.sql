USE world2;
ALTER TABLE City DROP FOREIGN KEY city_ibfk_1;
ALTER TABLE City Engine=RocksDB;
