
# StimulusReflex Demo

 * Ruby version: 2.7.0

 * System dependencies

    * NodeJS : 12.9.1
    * Rails: 6.0.3.3
    * PostgreSQL: 12.4

 * Configuration
	* Environment constant

      Create file .env.local with some values:
    
			  DB_NAME=<database name>
			  DB_USER=<database username>
			  DB_PASS=<database password>
      
	* Create database on postgreSQL database
	  
			rails  db:create
      
	* Run migrate
	
			rails db:migrate
