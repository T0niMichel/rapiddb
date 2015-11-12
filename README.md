# rapiddb
Default Postgresql Database (exposes default port)

1. Installs Postgresql Server 
2. Creates a PostgreSQL role named ``rapiddb`` with ``rapiddb`` as password.
3. Creates default Databases (develop, testing, production) database all owned by ``rapiddb``.
4. Grants accesst for those Databases