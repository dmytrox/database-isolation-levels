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
| Read Uncommitted               |    1     |     1     |         1         |     1      |         1          |
| Read Committed                 |    0    |     1     |         1         |     0     |         1          |
| Repeatable Read                |    0    |     1     |         1         |     0     |         1          |
| Serializable                   |    0    |    0     |        0         |     0     |         0         |

## PostgreSQL

> The SQL standard defines one additional level, READ UNCOMMITTED. In PostgreSQL READ UNCOMMITTED is treated as READ COMMITTED.

| Isolation level (Read phenomena)    | Dirty reads | Lost updates | Non-repeatable reads | Phantom reads | Serialization anomaly |
| :-------------------------------- | :---------: | :----------: | :------------------: | :-----------: | :-------------------: |
| Read Committed (Read Uncommitted) |    0    |     1     |         1         |     1      |         1          |
| Repeatable Read                   |    0    |     1     |        0         |     0     |         1          |
| Serializable                      |    0    |    0     |        0         |     0     |         0         |
