#! /usr/bin/env python

#  runHorseRacingApplication Solution

import psycopg2, sys, datetime

# usage()
# Print error messages to stderr
def usage():
    print("Usage:  python3 runHorseRacingApplication.py userid pwd", file=sys.stderr)
    sys.exit(-1)
# end usage

# The three Python functions that for Lab4 should appear below.
# Write those functions, as described in Lab4 Section 4 (and Section 5,
# which describes the Stored Function used by the third C function).
#
# Write the tests of those function in main, as described in Section 6
# of Lab4.


 # winCountForHorse (myConn, theHorseID):
 # The winCountForHorse Python function returns the number of times that a horse particular ID
 # finished first in a race.  The arguments for winCountForHorse  are the database connection and
 # the ID of the horse.
 #
 # It is not an error if there is no horse with that ID.  If there are no races in which the horse
 # finished first, then winCountForHorse  should return 0.

def winCountForHorse (myConn, theHorseID):

    # Python function to be supplied by students
    # You'll need to figure out value to return.
    try:
        myCursor = myConn.cursor()
        sql = "SELECT COUNT(finishPosition) FROM HorseRaceResults WHERE finishPosition = 1 AND horseId = %s" # count num of tuples from HRR where finPos is 1,
        myCursor.execute(sql, (theHorseID,))                                                                 # and the horseID is equal to theHorseID argument.
    except:
        print("Call of winCountForHorse on", theHorseID, "had error", file=sys.stderr) # Error message
        myCursor.close()
        myConn.close()
        sys.exit(-1)

    row = myCursor.fetchone() # get next row
    myCursor.close()
    return(row[0])


# end winCountForHorse


# updateRacetrackAddress (myConn, oldAddress, newAddress ):
# address is an attribute of the racetracks table.  Sometimes the address of a racetrack may change. different city.
#
# Besides the database connection, the updateRacetrackAddress Python function has two arguments, a
# string argument oldAddress and a string argument newAddress.  For every racetrack in the racetracks
# table (if any) whose address equals oldAddress, updateRacetrackAddress  should change that
# racetrack’s address to be newAddress.
#
# There might be no racetrack whose address equals oldAddress; that’s not an error.  There also might
# be one or more racetracks whose address equals oldAddress (since multiple racetracks might have
# the same address).  updateRacetrackAddress should return the number of racetracks whose address
# was updated.

def updateRacetrackAddress (myConn, oldAddress, newAddress):
    
    # Python function to be supplied by students
    # You'll need to figure out value to return.
    try:
        myCursor = myConn.cursor()
        sql = "UPDATE Racetracks SET address = %s WHERE address = %s" # Update RT so address oldAddress becomes newAddress, only if oldAddress arguement matches address in RT table.
        myCursor.execute(sql, (newAddress, oldAddress)) # Tells the compiler to execute in following order for arguments.
    except:
        print("Call of updateRacetrackAddress on", oldAddress, ",", newAddress, "had error", file=sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)

    row = myCursor.rowcount # Get row count
    myCursor.close()
    return(row)

# end updateRacetrackAddress


# disqualifyHorseInRace (myConn, theHorseID, theRacetrackID, theRaceDate, theRaceNum):
# Besides the database connection, this Python function has four other parameters:
#    theHorseID which is an integer,
#    theRacetrackID which is an integer,
#    theRaceDate which is a date,
#    theRaceNum, which is an integer
# disqualifyHorseInRace invokes a Stored Function, disqualifyHorseInRaceFunction, that you will
# need to implement and store in the database according to the description in Section 5.
# The Stored Function disqualifyHorseInRaceFunction has all the same parameters as
# disqualifyHorseInRace (except for the database connection, which is not a parameter for the
# Stored Function), and it returns an integer.
#
# Section 5 tells you what “disqualifying a horse in a race” mean, and explains the integer value
# that disqualifyHorseInRaceFunction returns.  The disqualifyHorseInRace Python function returns
# the same integer value that the disqualifyHorseInRaceFunction Stored Function returns.
#
# The disqualifyHorseInRace function must only invoke the Stored Function
# disqualifyHorseInRaceFunction, which does all of the work for this part of the assignment;
# disqualifyHorseInRace should not do any of the work itself.

def disqualifyHorseInRace (myConn, theHorseID, theRacetrackID, theRaceDate, theRaceNum):

# We're gving you the code for disqualifyHorseInRace, but you'll have to write
# the Stored Function disqualifyHorseInRaceFunction yourselves in a PL/pgSQL file named
# disqualifyHorseInRaceFunction.pgsql
    
    try:
        myCursor = myConn.cursor()
        sql = "SELECT disqualifyHorseInRaceFunction(%s, %s, %s, %s)"
        myCursor.execute(sql, (theHorseID, theRacetrackID, theRaceDate, theRaceNum ))
    except:
        print("Call of disqualifyHorseInRaceFunction on", theHorseID, theRacetrackID, theRaceDate, theRaceNum, "had error", file=sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)
    
    row = myCursor.fetchone()
    myCursor.close()
    return(row[0])

#end disqualifyHorseInRace


def main():

    if len(sys.argv)!=3:
       usage()

    hostname = "cse182-db.lt.ucsc.edu"
    userID = sys.argv[1]
    pwd = sys.argv[2]

    # Try to make a connection to the database
    try:
        myConn = psycopg2.connect(host=hostname, user=userID, password=pwd)
    except:
        print("Connection to database failed", file=sys.stderr)
        sys.exit(-1)
        
    # We're making every SQL statement a transaction that commits.
    # Don't need to explicitly begin a transaction.
    # Could have multiple statement in a transaction, using myConn.commit when we want to commit.
    myConn.autocommit = True
    
    # There are other correct ways of writing all of these calls correctly in Python.
        
    
    # Perform the calls to winCountForHorse  described in Section 6 of Lab4.
    # Print their outputs from here, not in winCountForHorses.
    # You may use a Python method to help you do the printing.
    
    # winCountForHorse tests
    print("winCountForHorse() Test:")

    horseID1 = "526"  # first horseID for test case 1
    winCount1 = winCountForHorse(myConn, horseID1)  # number of wins for first test case
    print("Horse", horseID1, "won", winCount1, "races\n")

    
    horseID2 = "555"  # second horseID for test case 2
    winCount2 = winCountForHorse(myConn, horseID2)  # number of winds for seconde test case
    print("Horse", horseID2, "won", winCount2, "races\n")



    # Print their outputs from here, not in updateRacetrackAddress.
    # You may use a Python method to help you do the printing.
    
    # updateRaceTrackAddress() tests

    print("updateRaceTrackAddress() Tests:")
    #  Test Case 1
    oldAddress1 = "Kellogg Rd 6301, Cincinnati, OH 45230"  # old address for test case 1
    newAddress1 = "6301 Kellogg Road, Cincinnati, OH 45230"  # new address for test case 1
    updateTrackAddress_Test1 = updateRacetrackAddress(myConn, oldAddress1, newAddress1)  # number of track addresses changed with test case 1
    print("Number of racetracks with whose address was changed from", oldAddress1, "to", newAddress1, "is", updateTrackAddress_Test1, "\n")

    
    #  Test Case 2
    oldAddress2 = "Elmont, NY 11003"  # old address for test case 2
    newAddress2 = "Belmont Park, NY 11003"  # new address for test case 2
    updateTrackAddress_Test2 = updateRacetrackAddress(myConn, oldAddress2, newAddress2)  # number of track addresses changed with test case 2
    print("Number of racetracks with whose address was changed from", oldAddress2, "to", newAddress2, "is", updateTrackAddress_Test2, "\n")



    # Perform the calls to disqualifyHorseInRace described in Section 6 of Lab4,
    # Print their outputs from here, not in disqualifyHorseInRace.
    # You may use a Python method to help you do the printing.
    #
    # Reminder:  As the Lab4 pdf tells you:
    

    # stored function tests:
    
    # stored test variables (Excluding horseID)
    stored_racetrackID = 3008
    stored_raceDate = datetime.date(2021, 8,11)
    stored_raceNum = 1

    #horseID for different test cases (Num at end of stored_horseIDx refers to test case)
    stored_horseID1 = 552
    stored_horseID2 = 553
    stored_horseID3 = 575

    

    # Test case 1 for disqualifyHorseInRace()
    disqualifyNum1 = disqualifyHorseInRace(myConn, stored_horseID1, stored_racetrackID, stored_raceDate, stored_raceNum)

    print("\n\n")
    print("disqualifyHorseInRace()/stored function Tests:")

    if (disqualifyNum1 == -2): # For when finPosition of horse is NULL
        print("Error encountered: Calling disqualifyHorseInRace() on horse with NULL finishPosition. -2 was returned")
        # parameters of disqualifyHorseInRace
        print("horseID:", stored_horseID1, "; racetrackID:", stored_racetrackID,  ",; raceDate:", stored_raceDate, "; raceNum:", stored_raceNum, "\n")
    elif (disqualifyNum1 == -1): # For when no tuple for that horse in that race
        print("Error encountered: Calling disqualifyHorseInRace() on horse's tuple that's not in HorseRaceResults table. -1 was returned")
        # parameters of disqualifyHorseInRace
        print("horseID:", stored_horseID1)
        print("racetrackID:", stored_racetrackID)
        print("raceDate:", stored_raceDate)
        print("raceNum:", stored_raceNum)
        print("\n")
    else:   # parameters of disqualifyHorseInRace, and number of finishPosition improvements
        print("Number of improvements:", disqualifyNum1, ", horseID:", stored_horseID1, ", racetrackID:", stored_racetrackID, ", raceDate:", stored_raceDate, ", raceNum:", stored_raceNum, "\n")

    


    # Test case 2 for disqualifyHorseInRace() 
    disqualifyNum2 = disqualifyHorseInRace(myConn, stored_horseID2, stored_racetrackID, stored_raceDate, stored_raceNum)

    if (disqualifyNum2 == -2): # For when finPosition of horse is NULL
        print("Error encountered: Calling disqualifyHorseInRace() on horse with NULL finishPosition. -2 was returned")
        # parameters of disqualifyHorseInRace
        print("horseID:", stored_horseID2, "; racetrackID:", stored_racetrackID,  ",; raceDate:", stored_raceDate, "; raceNum:", stored_raceNum, "\n")
    elif (disqualifyNum2 == -1): # For when no tuple for that horse in that race
        print("Error encountered: Calling disqualifyHorseInRace() on horse's tuple that's not in HorseRaceResults table. -1 was returned")
        # parameters of disqualifyHorseInRace
        print("horseID:", stored_horseID2)
        print("racetrackID:", stored_racetrackID)
        print("raceDate:", stored_raceDate)
        print("raceNum:", stored_raceNum)
        print("\n")
    else:   # parameters of disqualifyHorseInRace, and number of finishPosition improvements
        print("Number of improvements:", disqualifyNum2, ", horseID:", stored_horseID2, ", racetrackID:", stored_racetrackID, ", raceDate:", stored_raceDate, ", raceNum:", stored_raceNum, "\n")




    # Test case 3 for disqualifyHorseInRace() 
    disqualifyNum3 = disqualifyHorseInRace(myConn, stored_horseID3, stored_racetrackID, stored_raceDate, stored_raceNum)

    if (disqualifyNum3 == -2): # For when finPosition of horse is NULL
        print("Error encountered: Calling disqualifyHorseInRace() on horse with NULL finishPosition. -2 was returned")
        print("horseID:", stored_horseID3, "; racetrackID:", stored_racetrackID,  ",; raceDate:", stored_raceDate, "; raceNum:", stored_raceNum, "\n")
    elif (disqualifyNum3 == -1): # For when no tuple for that horse in that race
        print("Error encountered: Calling disqualifyHorseInRace() on horse's tuple that's not in HorseRaceResults table. -1 was returned")
        # parameters of disqualifyHorseInRace
        print("horseID:", stored_horseID3)
        print("racetrackID:", stored_racetrackID)
        print("raceDate:", stored_raceDate)
        print("raceNum:", stored_raceNum)
        print("\n")
    else:   # parameters of disqualifyHorseInRace, and number of finishPosition improvements 
        print("Number of improvements:", disqualifyNum3, ", horseID:", stored_horseID3, ", racetrackID:", stored_racetrackID, ", raceDate:", stored_raceDate, ", raceNum:", stored_raceNum, "\n")


    #
    # Note:  Since we’ve included the datetime() class in the Python skeleton for
    # runHorseRacingApplication.py, writing datetime.date(2021, 8, 11) giving you a Python
    # date object that corresponds to August 11, 2021, and that Python date object can be
    # the argument for a PL/pgSQL stored function which expects a date parameter.
    

    myConn.close()
    sys.exit(0)
#end

#------------------------------------------------------------------------------
if __name__=='__main__':

    main()

# end
