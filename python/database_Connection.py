import pyodbc
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import axes3d

server = ''
database = ''
username = ''
password = ''

cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)

cursor = cnxn.cursor()

def question1():
    cursor.execute('SELECT DISTINCT YEAR(release_date) AS Year, COUNT(*) AS Movies_per_year FROM movie WHERE budget > 1000000 GROUP BY YEAR(release_date) ORDER BY YEAR(release_date);')
    x = []
    y = []
    for i in cursor:
        x.append(i[0])
        y.append(i[1])

    plt.title('Question 1')   
    plt.xlabel('Year')
    plt.ylabel('Movies_per_year')
    plt.bar(x,y)
    plt.show()

def question2():
    cursor.execute('SELECT DISTINCT g.name AS Genre, COUNT(*) AS Movies_per_genre FROM genre g JOIN hasGenre hg ON hg.genre_id = g.id JOIN movie m ON hg.movie_id = m.id WHERE m.budget > 1000000 OR runtime > 120 GROUP BY g.name ORDER BY COUNT(*);')
    x = []
    y = []
    for i in cursor:
        x.append(i[0])
        y.append(i[1])

    plt.title('Question 2')   
    plt.xlabel('Genre')
    plt.ylabel('Movies_per_genre')
    plt.bar(x,y)
    plt.show()

def question3():
    cursor.execute('SELECT YEAR(release_date) AS Year, g.name AS Genre, COUNT(*) AS Movies_per_gy FROM genre g JOIN hasGenre hg ON hg.genre_id = g.id JOIN movie m ON hg.movie_id = m.id GROUP BY YEAR(release_date), g.name HAVING YEAR(release_date) > 0 ORDER BY YEAR(release_date);')

    y = []
    xCategories = []
    dz = []
    for i in cursor:
        y.append(i[0])
        xCategories.append(i[1])
        dz.append(i[2])

    fig = plt.figure()
    ax1 = fig.add_subplot(111, projection='3d')
    ax1.set_facecolor((1.0, 1.0, 1.0))

    i=0
    xDict = {}
    x=[]
    for category in xCategories:
        if category not in xDict:
            xDict[category]=i
            x.append(i)
            i+=1
        else:
            x.append(xDict[category])
    
    z = np.zeros(len(dz))

    dx = np.ones(len(x))*0.01
    dy = np.ones(len(y))
    
    ax1.bar3d(x, y, z, dx, dy, dz)

    plt.title('Question 3')   
    plt.xlabel('Genre')
    plt.ylabel('Year')
    ax1.set_zlabel('Movies_per_gy')

    plt.xticks(range(len(xDict.values())), xDict.keys())
    plt.show()

def question4():
    cursor.execute('SELECT DISTINCT YEAR(release_date) AS Year, SUM(revenue) AS Revenues_per_year  FROM movie m JOIN movie_cast mc ON mc.movie_id = m.id WHERE mc.person_id = 3131 GROUP BY YEAR(release_date) ORDER BY YEAR(release_date);')
    x = []
    y = []
    for i in cursor:
        x.append(i[0])
        y.append(i[1])

    plt.title('Question 4')   
    plt.xlabel('Year')
    plt.ylabel('Revenues_per_year')
    plt.bar(x,y)
    plt.show()

def question5():
    cursor.execute('SELECT DISTINCT YEAR(release_date) AS Year, MAX(budget) AS Max_budget FROM movie WHERE budget > 0 GROUP BY YEAR(release_date) ORDER BY YEAR(release_date);')
    x = []
    y = []
    for i in cursor:
        x.append(i[0])
        y.append(i[1])

    plt.title('Question 5')   
    plt.xlabel('Year')
    plt.ylabel('Max_budget')
    plt.bar(x,y)
    plt.show()

def question7():
    cursor.execute('SELECT AVG(rating) AS Avg_rating, COUNT(user_id) AS Rating_count FROM ratings GROUP BY user_id;')
    x = np.array([])
    y = np.array([])
    for i in cursor:
        x = np.append(x, i[0])
        y = np.append(y, i[1])

    plt.title('Question 7') 
    plt.xlabel('Avg_rating')
    plt.ylabel('Rating_count')
    plt.scatter(x, y,s=1)
    plt.show()

#question1()
#question2()
#question3()
#question4()
#question5()
#question7()