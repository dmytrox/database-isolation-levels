# Percona and PostgreSQL isolation levels

To start app run this command in your terminal

```
make up
```

> All request you can found under DMS folders.

# Conclusion

## Percona

| Isolation level (Read phenomena) | Dirty reads | Lost updates | Non-repeatable reads | Phantom reads | Serialization anomaly |
| :----------------------------- | :---------: | :----------: | :------------------: | :-----------: | :-------------------: |
| Read Uncommitted               |    true     |     true     |         true         |     true      |         true          |
| Read Committed                 |    false    |     true     |         true         |     false     |         true          |
| Repeatable Read                |    false    |     true     |         true         |     false     |         true          |
| Serializable                   |    false    |    false     |        false         |     false     |         false         |

## PostgreSQL

> The SQL standard defines one additional level, READ UNCOMMITTED. In PostgreSQL READ UNCOMMITTED is treated as READ COMMITTED.

| Isolation level (Read phenomena)    | Dirty reads | Lost updates | Non-repeatable reads | Phantom reads | Serialization anomaly |
| :-------------------------------- | :---------: | :----------: | :------------------: | :-----------: | :-------------------: |
| Read Committed (Read Uncommitted) |    false    |     true     |         true         |     true      |         true          |
| Repeatable Read                   |    false    |     true     |        false         |     false     |         true          |
| Serializable                      |    false    |    false     |        false         |     false     |         false         |
