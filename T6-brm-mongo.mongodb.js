// *****PLEASE ENTER YOUR DETAILS BELOW*****
// T6-brm-mongo.mongodb.js

// Student ID:35135913
// Student Name:Nicholas Wong Wei Junn

// ===================================================================================
// DO NOT modify or remove any of the comments below (items marked with //)
// Do not use .pretty() in your code, it is not required
//
// -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
// In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
// ===================================================================================

// Use (connect to) your database - you MUST update xyz001
// with your authcate username
use("nwon0059");
//use("abc001");

// (b)
// PLEASE PLACE REQUIRED MONGODB COMMAND TO CREATE THE COLLECTION HERE
// YOU MAY PICK ANY COLLECTION NAME
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer
// Create a collection and insert the JSON documents generated
// from T6-brm-json.sql.

// Drop collection
db.brmcustomer.drop();
// Create collection and insert documents
db.brmcustomer.insertMany([
    {
        "_id": 1,
        "customer_name": "Michael Benjamin",
        "customer_business": "FreshBox",
        "customer_address": "55 Lonsdale Street, Melbourne, 3008",
        "customer_phone": "0478901017",
        "customer_stats": {
            "number_of_quotes": 2,
            "number_of_jobs": 2,
            "total_paid_jobcost": "$2125.00",
            "total_unpaid_jobcost": "-"
        },
        "quotes": [
            {
                "quote_no": 1,
                "quote_prepared_on": "01-May-2026",
                "preferred_start_date": "05-May-2026",
                "start_location": "55 Lonsdale Street, Melbourne",
                "end_location": "42 Collins Street, Melbourne",
                "quote_cost": "$1250.00",
                "assigned_to_job": "Y",
                "job_cost": "$1250.00"
            },
            {
                "quote_no": 11,
                "quote_prepared_on": "11-May-2026",
                "preferred_start_date": "19-May-2026",
                "start_location": "55 Lonsdale Street, Melbourne",
                "end_location": "56 Bourke Street, Melbourne",
                "quote_cost": "$875.00",
                "assigned_to_job": "Y",
                "job_cost": "$875.00"
            }
        ]
    },
    {
        "_id": 2,
        "customer_name": "James",
        "customer_business": "J Wood and Gravel",
        "customer_address": "15 George Street, Sydney, 2000",
        "customer_phone": "0412345001",
        "customer_stats": {
            "number_of_quotes": 2,
            "number_of_jobs": 2,
            "total_paid_jobcost": "$3160.00",
            "total_unpaid_jobcost": "-"
        },
        "quotes": [
            {
                "quote_no": 2,
                "quote_prepared_on": "02-May-2026",
                "preferred_start_date": "06-May-2026",
                "start_location": "15 George Street, Sydney",
                "end_location": "127 Parramatta Road, Sydney",
                "quote_cost": "$1850.00",
                "assigned_to_job": "Y",
                "job_cost": "$1950.00"
            },
            {
                "quote_no": 12,
                "quote_prepared_on": "12-May-2026",
                "preferred_start_date": "20-May-2026",
                "start_location": "15 George Street, Sydney",
                "end_location": "92 Oxford Street, Sydney",
                "quote_cost": "$1210.00",
                "assigned_to_job": "Y",
                "job_cost": "$1210.00"
            }
        ]
    },
    {
        "_id": 3,
        "customer_name": "Brook",
        "customer_business": "Western Chocolatery",
        "customer_address": "23 Murray Street, Perth, 6000",
        "customer_phone": "0445678004",
        "customer_stats": {
            "number_of_quotes": 2,
            "number_of_jobs": 2,
            "total_paid_jobcost": "$1425.00",
            "total_unpaid_jobcost": "$1085.00"
        },
        "quotes": [
            {
                "quote_no": 3,
                "quote_prepared_on": "03-May-2026",
                "preferred_start_date": "07-May-2026",
                "start_location": "23 Murray Street, Perth",
                "end_location": "38 Wellington Street, Perth",
                "quote_cost": "$1425.00",
                "assigned_to_job": "Y",
                "job_cost": "$1425.00"
            },
            {
                "quote_no": 13,
                "quote_prepared_on": "13-May-2026",
                "preferred_start_date": "22-May-2026",
                "start_location": "23 Murray Street, Perth",
                "end_location": "29 Barrack Street, Perth",
                "quote_cost": "$995.00",
                "assigned_to_job": "Y",
                "job_cost": "$1085.00"
            }
        ]
    },
    {
        "_id": 4,
        "customer_name": "Alexander Noah",
        "customer_business": "-",
        "customer_address": "56 Bourke Street, Melbourne, 3001",
        "customer_phone": "0478901007",
        "customer_stats": {
            "number_of_quotes": 2,
            "number_of_jobs": 2,
            "total_paid_jobcost": "$760.00",
            "total_unpaid_jobcost": "$1040.00"
        },
        "quotes": [
            {
                "quote_no": 4,
                "quote_prepared_on": "04-May-2026",
                "preferred_start_date": "09-May-2026",
                "start_location": "56 Bourke Street, Melbourne",
                "end_location": "18 Chapel Street, Melbourne",
                "quote_cost": "$980.00",
                "assigned_to_job": "Y",
                "job_cost": "$1040.00"
            },
            {
                "quote_no": 14,
                "quote_prepared_on": "14-May-2026",
                "preferred_start_date": "23-May-2026",
                "start_location": "56 Bourke Street, Melbourne",
                "end_location": "42 Collins Street, Melbourne",
                "quote_cost": "$760.00",
                "assigned_to_job": "Y",
                "job_cost": "$760.00"
            }
        ]
    },
    {
        "_id": 5,
        "customer_name": "Jack Ethan",
        "customer_business": "-",
        "customer_address": "61 Ann Street, Brisbane, 4101",
        "customer_phone": "0434567013",
        "customer_stats": {
            "number_of_quotes": 2,
            "number_of_jobs": 2,
            "total_paid_jobcost": "$2860.00",
            "total_unpaid_jobcost": "-"
        },
        "quotes": [
            {
                "quote_no": 5,
                "quote_prepared_on": "05-May-2026",
                "preferred_start_date": "10-May-2026",
                "start_location": "61 Ann Street, Brisbane",
                "end_location": "72 Cavill Avenue, Brisbane",
                "quote_cost": "$1320.00",
                "assigned_to_job": "Y",
                "job_cost": "$1320.00"
            },
            {
                "quote_no": 15,
                "quote_prepared_on": "15-May-2026",
                "preferred_start_date": "25-May-2026",
                "start_location": "61 Ann Street, Brisbane",
                "end_location": "88 Queen Street, Brisbane",
                "quote_cost": "$1475.00",
                "assigned_to_job": "Y",
                "job_cost": "$1540.00"
            }
        ]
    },
    {
        "_id": 6,
        "customer_name": "Sophie Amelia",
        "customer_business": "-",
        "customer_address": "29 Barrack Street, Perth, 6009",
        "customer_phone": "0445678014",
        "customer_stats": {
            "number_of_quotes": 2,
            "number_of_jobs": 2,
            "total_paid_jobcost": "-",
            "total_unpaid_jobcost": "$4910.00"
        },
        "quotes": [
            {
                "quote_no": 6,
                "quote_prepared_on": "06-May-2026",
                "preferred_start_date": "12-May-2026",
                "start_location": "29 Barrack Street, Perth",
                "end_location": "88 Queen Street, Brisbane",
                "quote_cost": "$3950.00",
                "assigned_to_job": "Y",
                "job_cost": "$4100.00"
            },
            {
                "quote_no": 16,
                "quote_prepared_on": "16-May-2026",
                "preferred_start_date": "27-May-2026",
                "start_location": "29 Barrack Street, Perth",
                "end_location": "23 Murray Street, Perth",
                "quote_cost": "$810.00",
                "assigned_to_job": "Y",
                "job_cost": "$810.00"
            }
        ]
    },
    {
        "_id": 7,
        "customer_name": "Kate Evelyn",
        "customer_business": "Miller Co.",
        "customer_address": "72 Cavill Avenue, Brisbane, 4217",
        "customer_phone": "0489012018",
        "customer_stats": {
            "number_of_quotes": 2,
            "number_of_jobs": 2,
            "total_paid_jobcost": "$2345.00",
            "total_unpaid_jobcost": "-"
        },
        "quotes": [
            {
                "quote_no": 7,
                "quote_prepared_on": "07-May-2026",
                "preferred_start_date": "13-May-2026",
                "start_location": "72 Cavill Avenue, Brisbane",
                "end_location": "34 Adelaide Street, Brisbane",
                "quote_cost": "$1160.00",
                "assigned_to_job": "Y",
                "job_cost": "$1160.00"
            },
            {
                "quote_no": 17,
                "quote_prepared_on": "17-May-2026",
                "preferred_start_date": "29-May-2026",
                "start_location": "72 Cavill Avenue, Brisbane",
                "end_location": "61 Ann Street, Brisbane",
                "quote_cost": "$1185.00",
                "assigned_to_job": "Y",
                "job_cost": "$1185.00"
            }
        ]
    },
    {
        "_id": 8,
        "customer_name": "Emma",
        "customer_business": "Kreate Curtain",
        "customer_address": "42 Collins Street, Melbourne, 3000",
        "customer_phone": "0423456002",
        "customer_stats": {
            "number_of_quotes": 2,
            "number_of_jobs": 2,
            "total_paid_jobcost": "$2160.00",
            "total_unpaid_jobcost": "-"
        },
        "quotes": [
            {
                "quote_no": 8,
                "quote_prepared_on": "08-May-2026",
                "preferred_start_date": "14-May-2026",
                "start_location": "42 Collins Street, Melbourne",
                "end_location": "55 Lonsdale Street, Melbourne",
                "quote_cost": "$1085.00",
                "assigned_to_job": "Y",
                "job_cost": "$1125.00"
            },
            {
                "quote_no": 18,
                "quote_prepared_on": "18-May-2026",
                "preferred_start_date": "31-May-2026",
                "start_location": "42 Collins Street, Melbourne",
                "end_location": "18 Chapel Street, Melbourne",
                "quote_cost": "$990.00",
                "assigned_to_job": "Y",
                "job_cost": "$1035.00"
            }
        ]
    },
    {
        "_id": 9,
        "customer_name": "William",
        "customer_business": "Best Fruit and Veg",
        "customer_address": "67 King William Street, Adelaide, 5000",
        "customer_phone": "0456789005",
        "customer_stats": {
            "number_of_quotes": 2,
            "number_of_jobs": 2,
            "total_paid_jobcost": "$920.00",
            "total_unpaid_jobcost": "$1200.00"
        },
        "quotes": [
            {
                "quote_no": 9,
                "quote_prepared_on": "09-May-2026",
                "preferred_start_date": "16-May-2026",
                "start_location": "67 King William Street, Adelaide",
                "end_location": "45 Rundle Mall, Adelaide",
                "quote_cost": "$920.00",
                "assigned_to_job": "Y",
                "job_cost": "$920.00"
            },
            {
                "quote_no": 19,
                "quote_prepared_on": "19-May-2026",
                "preferred_start_date": "02-Jun-2026",
                "start_location": "67 King William Street, Adelaide",
                "end_location": "83 Jetty Road, Adelaide",
                "quote_cost": "$1130.00",
                "assigned_to_job": "Y",
                "job_cost": "$1200.00"
            }
        ]
    },
    {
        "_id": 10,
        "customer_name": "Grace",
        "customer_business": "-",
        "customer_address": "45 Rundle Mall, Adelaide, 5006",
        "customer_phone": "0401234010",
        "customer_stats": {
            "number_of_quotes": 2,
            "number_of_jobs": 2,
            "total_paid_jobcost": "$945.00",
            "total_unpaid_jobcost": "$980.00"
        },
        "quotes": [
            {
                "quote_no": 10,
                "quote_prepared_on": "10-May-2026",
                "preferred_start_date": "17-May-2026",
                "start_location": "45 Rundle Mall, Adelaide",
                "end_location": "94 Henley Beach Road, Adelaide",
                "quote_cost": "$1035.00",
                "assigned_to_job": "Y",
                "job_cost": "$980.00"
            },
            {
                "quote_no": 20,
                "quote_prepared_on": "20-May-2026",
                "preferred_start_date": "04-Jun-2026",
                "start_location": "45 Rundle Mall, Adelaide",
                "end_location": "67 King William Street, Adelaide",
                "quote_cost": "$945.00",
                "assigned_to_job": "Y",
                "job_cost": "$945.00"
            }
        ]
    },
    {
        "_id": 11,
        "customer_name": "Rose Isabella",
        "customer_business": "-",
        "customer_address": "34 Adelaide Street, Brisbane, 4006",
        "customer_phone": "0489012008",
        "customer_stats": {
            "number_of_quotes": 1,
            "number_of_jobs": 0,
            "total_paid_jobcost": "-",
            "total_unpaid_jobcost": "-"
        },
        "quotes": [
            {
                "quote_no": 21,
                "quote_prepared_on": "21-May-2026",
                "preferred_start_date": "06-Jun-2026",
                "start_location": "34 Adelaide Street, Brisbane",
                "end_location": "72 Cavill Avenue, Brisbane",
                "quote_cost": "$1295.00",
                "assigned_to_job": "N",
                "job_cost": "-"
            }
        ]
    },
    {
        "_id": 12,
        "customer_name": "Robert James",
        "customer_business": "Wilson Confectionery",
        "customer_address": "38 Wellington Street, Perth, 6107",
        "customer_phone": "0490123019",
        "customer_stats": {
            "number_of_quotes": 1,
            "number_of_jobs": 0,
            "total_paid_jobcost": "-",
            "total_unpaid_jobcost": "-"
        },
        "quotes": [
            {
                "quote_no": 22,
                "quote_prepared_on": "22-May-2026",
                "preferred_start_date": "08-Jun-2026",
                "start_location": "38 Wellington Street, Perth",
                "end_location": "29 Barrack Street, Perth",
                "quote_cost": "$1040.00",
                "assigned_to_job": "N",
                "job_cost": "-"
            }
        ]
    },
    {
        "_id": 13,
        "customer_name": "Oliver",
        "customer_business": "Williams Co.",
        "customer_address": "88 Queen Street, Brisbane, 4000",
        "customer_phone": "0434567003",
        "customer_stats": {
            "number_of_quotes": 1,
            "number_of_jobs": 0,
            "total_paid_jobcost": "-",
            "total_unpaid_jobcost": "-"
        },
        "quotes": [
            {
                "quote_no": 23,
                "quote_prepared_on": "23-May-2026",
                "preferred_start_date": "10-Jun-2026",
                "start_location": "88 Queen Street, Brisbane",
                "end_location": "61 Ann Street, Brisbane",
                "quote_cost": "$1505.00",
                "assigned_to_job": "N",
                "job_cost": "-"
            }
        ]
    },
    {
        "_id": 14,
        "customer_name": "Price",
        "customer_business": "Garcia Frozen",
        "customer_address": "101 Pitt Street, Sydney, 2010",
        "customer_phone": "0467890006",
        "customer_stats": {
            "number_of_quotes": 1,
            "number_of_jobs": 0,
            "total_paid_jobcost": "-",
            "total_unpaid_jobcost": "-"
        },
        "quotes": [
            {
                "quote_no": 24,
                "quote_prepared_on": "24-May-2026",
                "preferred_start_date": "12-Jun-2026",
                "start_location": "101 Pitt Street, Sydney",
                "end_location": "15 George Street, Sydney",
                "quote_cost": "$1360.00",
                "assigned_to_job": "N",
                "job_cost": "-"
            }
        ]
    },
    {
        "_id": 15,
        "customer_name": "Thomas",
        "customer_business": "-",
        "customer_address": "78 Hay Street, Perth, 6003",
        "customer_phone": "0490123009",
        "customer_stats": {
            "number_of_quotes": 1,
            "number_of_jobs": 0,
            "total_paid_jobcost": "-",
            "total_unpaid_jobcost": "-"
        },
        "quotes": [
            {
                "quote_no": 25,
                "quote_prepared_on": "25-May-2026",
                "preferred_start_date": "14-Jun-2026",
                "start_location": "78 Hay Street, Perth",
                "end_location": "23 Murray Street, Perth",
                "quote_cost": "$1175.00",
                "assigned_to_job": "N",
                "job_cost": "-"
            }
        ]
    },
    {
        "_id": 16,
        "customer_name": "Henry Lucas",
        "customer_business": "-",
        "customer_address": "92 Oxford Street, Sydney, 2060",
        "customer_phone": "0412345011",
        "customer_stats": {
            "number_of_quotes": 1,
            "number_of_jobs": 0,
            "total_paid_jobcost": "-",
            "total_unpaid_jobcost": "-"
        },
        "quotes": [
            {
                "quote_no": 26,
                "quote_prepared_on": "26-May-2026",
                "preferred_start_date": "16-Jun-2026",
                "start_location": "92 Oxford Street, Sydney",
                "end_location": "127 Parramatta Road, Sydney",
                "quote_cost": "$1245.00",
                "assigned_to_job": "N",
                "job_cost": "-"
            }
        ]
    },
    {
        "_id": 17,
        "customer_name": "Lily Charlotte",
        "customer_business": "-",
        "customer_address": "18 Chapel Street, Melbourne, 3004",
        "customer_phone": "0423456012",
        "customer_stats": {
            "number_of_quotes": 1,
            "number_of_jobs": 0,
            "total_paid_jobcost": "-",
            "total_unpaid_jobcost": "-"
        },
        "quotes": [
            {
                "quote_no": 27,
                "quote_prepared_on": "27-May-2026",
                "preferred_start_date": "18-Jun-2026",
                "start_location": "18 Chapel Street, Melbourne",
                "end_location": "55 Lonsdale Street, Melbourne",
                "quote_cost": "$890.00",
                "assigned_to_job": "N",
                "job_cost": "-"
            }
        ]
    },
    {
        "_id": 18,
        "customer_name": "Victoria Ella",
        "customer_business": "Flintstone Store",
        "customer_address": "94 Henley Beach Road, Adelaide, 5095",
        "customer_phone": "0401234020",
        "customer_stats": {
            "number_of_quotes": 2,
            "number_of_jobs": 0,
            "total_paid_jobcost": "-",
            "total_unpaid_jobcost": "-"
        },
        "quotes": [
            {
                "quote_no": 28,
                "quote_prepared_on": "28-May-2026",
                "preferred_start_date": "20-Jun-2026",
                "start_location": "94 Henley Beach Road, Adelaide",
                "end_location": "45 Rundle Mall, Adelaide",
                "quote_cost": "$1075.00",
                "assigned_to_job": "N",
                "job_cost": "-"
            },
            {
                "quote_no": 300,
                "quote_prepared_on": "17-May-2026",
                "preferred_start_date": "25-May-2026",
                "start_location": "29 Kuranda Road, Adelaide SA 5030",
                "end_location": "9 Albatros Drive, Mount Gambier SA 5270",
                "quote_cost": "$1000.00",
                "assigned_to_job": "N",
                "job_cost": "-"
            }
        ]
    },
    {
        "_id": 19,
        "customer_name": "Daniel Mason",
        "customer_business": "-",
        "customer_address": "83 Jetty Road, Adelaide, 5063",
        "customer_phone": "0456789015",
        "customer_stats": {
            "number_of_quotes": 1,
            "number_of_jobs": 0,
            "total_paid_jobcost": "-",
            "total_unpaid_jobcost": "-"
        },
        "quotes": [
            {
                "quote_no": 29,
                "quote_prepared_on": "29-May-2026",
                "preferred_start_date": "22-Jun-2026",
                "start_location": "83 Jetty Road, Adelaide",
                "end_location": "67 King William Street, Adelaide",
                "quote_cost": "$1195.00",
                "assigned_to_job": "N",
                "job_cost": "-"
            }
        ]
    },
    {
        "_id": 20,
        "customer_name": "Emily Harper",
        "customer_business": "-",
        "customer_address": "127 Parramatta Road, Sydney, 2150",
        "customer_phone": "0467890016",
        "customer_stats": {
            "number_of_quotes": 1,
            "number_of_jobs": 0,
            "total_paid_jobcost": "-",
            "total_unpaid_jobcost": "-"
        },
        "quotes": [
            {
                "quote_no": 30,
                "quote_prepared_on": "30-May-2026",
                "preferred_start_date": "24-Jun-2026",
                "start_location": "127 Parramatta Road, Sydney",
                "end_location": "15 George Street, Sydney",
                "quote_cost": "$1285.00",
                "assigned_to_job": "N",
                "job_cost": "-"
            }
        ]
    }
]);

// List all documents you added
db.brmcustomer.find();

// (c)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer
// List all customers who have made at least 2 quotes and live
// in Melbourne.
db.brmcustomer.find(
    {
        "customer_stats.number_of_quotes": { "$gt": 1 },
        "customer_address": /.*Melbourne.*/
    },
    {
        "customer_name": 1,
        "customer_address": 1,
        "customer_phone": 1,
        "customer_stats.number_of_quotes": 1,
        "customer_stats.number_of_jobs": 1,
        "customer_stats.total_paid_jobcost": 1,
        "customer_stats.total_unpaid_jobcost": 1
    }
);


// (d)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer
// Add customer Patrick Bosse with customer id 1001.
// (i)  Add the new customer
db.brmcustomer.insertOne(
    {
        "_id": 1001,
        "customer_name": "Patrick Bosse",
        "customer_business": "-",
        "customer_address": "10 King William Street, Adelaide, 5000",
        "customer_phone": "0499999001",
        "customer_stats": {
            "number_of_quotes": 0,
            "number_of_jobs": 0,
            "total_paid_jobcost": "-",
            "total_unpaid_jobcost": "-"
        },
        "quotes": []
    }
);

// Show the customer details
db.brmcustomer.find(
    { "_id": 1001 }
);


// (ii) Add new quote
// Add Patrick Bosse's first quote and update customer statistics.

// Show the customer details
db.brmcustomer.updateOne(
    { "_id": 1001 },
    {
        "$set": {
            "customer_stats.number_of_quotes": 1,
            "customer_stats.number_of_jobs": 1,
            "customer_stats.total_paid_jobcost": "$3200.00",
            "customer_stats.total_unpaid_jobcost": "-"
        },
        "$push": {
            "quotes": {
                "quote_no": 2002,
                "quote_prepared_on": "01-Jun-2026",
                "preferred_start_date": "10-Jun-2026",
                "start_location": "Adelaide SA",
                "end_location": "Melbourne VIC",
                "quote_cost": "$3200.00",
                "assigned_to_job": "Y",
                "job_cost": "$3200.00"
            }
        }
    }
);

db.brmcustomer.find(
    { "_id": 1001 }
);
// End of file - do not remove
