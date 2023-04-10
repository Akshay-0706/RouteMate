/**
 * @file router.c++
 * @author Akshay Vhatkar
 * @brief This program demonstrates how vehicle routing problem can be implemented
 *        using 3 different algorithms namely:
 *            1. K Means Clustering
 *            2. K Nearest Neighbours
 *            3. K Opt Optimization with K as 2
 * @version 0.1
 * @date 2023-03-20
 *
 * @copyright Copyright (c) 2023
 *
 */

#include <iostream>
#include <string>
#include <vector>
#include <cmath>
#include <cfloat>
#include <map>
#include <chrono>
#include <unordered_map>

using namespace std;
using namespace std::chrono;

/// @brief class Point which contains lattitude and longitude of the location
class Point
{
public:
    double lat;
    double lon;

    Point(double lat, double lon) : lat(lat), lon(lon) {}
};

/// @brief class Location which contains extra info along with Point of that location
class Location
{
public:
    bool isAdded = false;
    string name;
    Point *point;

    Location(string name, Point *point) : name(name), point(point) {}
};

/// @brief class Cluster which is a cluster of n points with centroid
class Cluster
{
public:
    int id;
    double distance = 0;
    Location *centroid;
    vector<Location *> locations;
    unordered_map<Location *, int> route;
    map<int, Location *> sortedRoute;

    Cluster(int id, Location *centroid) : id(id), centroid(centroid) { centroid->isAdded = true; }

    void addLocation(Location *location)
    {
        locations.push_back(location);
        centroid->point->lat = (centroid->point->lat + location->point->lat) / 2;
        centroid->point->lon = (centroid->point->lon + location->point->lon) / 2;
    }
};

int trucks;
Location *source, *destination;
unordered_map<Location *, unordered_map<Location *, double>> distances;
vector<Location *> locations;
vector<Cluster *> clusters;

double euclidienDistance(Point *l1, Point *l2);
void showClusters();
void kMeansClustering();
void calDistances();
void kNearestNeighbours(int current, int counter, Location *prev, Cluster *cluster);
void kOptOptimization(Cluster *cluster);

int main()
{
    auto start = high_resolution_clock::now();
    cout << "Program starts" << endl;

    trucks = 3;
    Point *sourceJogeshwari = new Point(19.137137, 72.848986);
    Point *destinationVileParle = new Point(19.100095, 72.843990);

    Point *homePoint = new Point(19.130036, 72.875422);
    Point *seepzDepotPoint = new Point(19.130543, 72.875092);
    Point *gate1Point = new Point(19.127401, 72.874772);
    Point *gate2Point = new Point(19.124188, 72.874793);
    Point *gate3Point = new Point(19.129718, 72.877752);

    Point *andheriPoint = new Point(19.119566, 72.846572);
    Point *andheriDepotPoint = new Point(19.119275, 72.848298);
    Point *macDPoint = new Point(19.118154, 72.847336);

    Point *bhavansPoint = new Point(19.123443, 72.836400);
    Point *vrindavanPoint = new Point(19.124684, 72.838136);
    Point *azadPoint = new Point(19.126708, 72.837662);
    Point *jagrutPoint = new Point(19.123394, 72.843435);

    // Point *sourceJogeshwari = new Point(190, 65);
    // Point *destinationVileParle = new Point(187, 75);

    // Point *homePoint = new Point(185, 72);
    // Point *seepzDepotPoint = new Point(170, 56);
    // Point *gate1Point = new Point(168, 60);
    // Point *gate2Point = new Point(179, 68);
    // Point *gate3Point = new Point(182, 72);

    // Point *andheriPoint = new Point(188, 77);
    // Point *andheriDepotPoint = new Point(180, 71);
    // Point *macDPoint = new Point(180, 70);

    // Point *bhavansPoint = new Point(183, 84);
    // Point *vrindavanPoint = new Point(180, 88);
    // Point *azadPoint = new Point(180, 67);
    // Point *jagrutPoint = new Point(177, 76);

    source = new Location("Jogeshwari", sourceJogeshwari);
    destination = new Location("Vile Parle", destinationVileParle);

    Location *home = new Location("Home", homePoint);
    Location *seepzDepot = new Location("Seepz Depot", seepzDepotPoint);
    Location *gate1 = new Location("Seepz Gate 1", gate1Point);
    Location *gate2 = new Location("Seepz Gate 2", gate2Point);
    Location *gate3 = new Location("Seepz Gate 3", gate3Point);

    Location *andheri = new Location("Andheri", andheriPoint);
    Location *andheriDepot = new Location("Andheri Depot", andheriDepotPoint);
    Location *macD = new Location("MacD", macDPoint);

    Location *bhavans = new Location("Bhavans", bhavansPoint);
    Location *vrindavan = new Location("Vrindavan", vrindavanPoint);
    Location *azad = new Location("Azad Nagar", azadPoint);
    Location *jagrut = new Location("Jagrut Sweets", jagrutPoint);

    locations.push_back(home);
    locations.push_back(seepzDepot);
    locations.push_back(gate1);
    locations.push_back(gate2);
    locations.push_back(gate3);
    locations.push_back(andheri);
    locations.push_back(andheriDepot);
    locations.push_back(macD);
    locations.push_back(bhavans);
    locations.push_back(vrindavan);
    locations.push_back(azad);
    locations.push_back(jagrut);

    Cluster *cluster1 = new Cluster(0, andheri);
    Cluster *cluster2 = new Cluster(1, macD);
    Cluster *cluster3 = new Cluster(2, andheriDepot);

    clusters.push_back(cluster1);
    clusters.push_back(cluster2);
    clusters.push_back(cluster3);

    kMeansClustering();
    showClusters();

    cluster1->locations.push_back(andheri);
    cluster2->locations.push_back(macD);
    cluster3->locations.push_back(andheriDepot);

    calDistances();

    // O((n - k) * k) iterations where k is number of clusters or trucks
    // O(n * (n + 1) / 2) or O(n^2), where n is number of locations inside the cluster[i], 0 <= i < cluster.size()
    // O((k + 1) * n * (n - 3) / 2) or O(n^2), where k is number of times we got better solutions for cluster[i] and n is number of locations inside the cluster[i], 0 <= i < cluster.size()
    cout << endl
         << "Time Complexity of K Means Clustering = O((n - k) * k) or O(k^2), where n is number of locations and k is number of clusters" << endl;
    cout << endl
         << "Time Complexity of K Nearest Neighbour = O(n * (n + 1) / 2) or O(n^2), where n is number of locations inside the cluster[i], 0 <= i < cluster.size()" << endl;
    cout << endl
         << "Time Complexity of K Opt Optimization = O((k + 1) * n * (n - 3) / 2) or O(n^2), where k is number of times we got better solutions for cluster[i] and n is number of locations inside the cluster[i], 0 <= i < cluster.size()" << endl;
    cout << endl
         << "==========================================" << endl
         << endl;

    double distance;
    for (auto &&cluster : clusters)
    {
        cout << "Cluster " << cluster->id << endl;
        cout << "n = " << cluster->locations.size() << endl;
        cout << "Iterations = ";
        kNearestNeighbours(0, 1, source, cluster);
        cout << endl;
        for (auto &&r : cluster->route)
            cluster->sortedRoute[r.second] = r.first;

        cout << "Route:" << endl;
        cout << "Start -> ";
        for (auto &&r : cluster->sortedRoute)
            cout << r.second->name << " -> ";
        cout << "End" << endl;
        cout << "Distance travelled = " << cluster->distance << endl
             << endl;

        cout << "Performing optimization:" << endl;
        distance = cluster->distance;
        kOptOptimization(cluster);
        if (cluster->distance < distance)
        {
            cout << "New route for Cluster " << cluster->id << endl;
            cout << "Start -> ";
            for (auto &&r : cluster->sortedRoute)
                cout << r.second->name << " -> ";
            cout << "End" << endl;
            cout << "Distance travelled = " << cluster->distance << endl
                 << endl;
        }
        else
            cout << "Cluster " << cluster->id << " cannot be optimized further!" << endl
                 << endl;
        cout << "==========================================" << endl
             << endl;

        cluster->sortedRoute[0] = source;
        cluster->sortedRoute[cluster->sortedRoute.size()] = destination;
    }

    cout << "Program ends" << endl;
    auto stop = high_resolution_clock::now();

    auto duration = duration_cast<milliseconds>(stop - start);

    // get duration. To cast it to proper unit
    // use duration cast method
    cout << "Time taken = "
         << duration.count() << " milliseconds" << endl;

    return 0;
}

double euclidienDistance(Point *l1, Point *l2)
{
    return sqrt(pow((l2->lat - l1->lat), 2) + pow((l2->lon - l1->lon), 2));
}

void showClusters()
{
    for (int i = 0; i < clusters.size(); i++)
    {
        cout << "\nCluster " << i + 1 << " with centroid = " << clusters[i]->centroid->name << endl;
        cout << "Contains locations ";
        for (int j = 0; j < clusters[i]->locations.size(); j++)
        {
            cout << clusters[i]->locations[j]->name;
            if (j < clusters[i]->locations.size() - 1)
                cout << ", ";
        }
        cout << endl;
    }
}

void kMeansClustering()
{
    int index = 0, counter = 1;
    double min = DBL_MAX, distance;
    cout << "\nIterations = ";
    for (auto &&location : locations)
    {
        if (location->isAdded)
            continue;

        min = DBL_MAX;
        for (int i = 0; i < clusters.size(); i++)
        {
            cout << counter++ << " ";
            distance = euclidienDistance(clusters[i]->centroid->point, location->point);
            if (min > distance)
            {
                min = distance;
                index = i;
            }
        }
        clusters[index]->addLocation(location);
        location->isAdded = true;
    }
    cout << endl;
}

void calDistances()
{
    double distance;

    for (int i = 0; i < locations.size() - 1; i++)
    {
        for (int j = i + 1; j < locations.size(); j++)
        {
            distance = euclidienDistance(locations[i]->point, locations[j]->point);
            distances[locations[i]][locations[j]] = distance;
            distances[locations[j]][locations[i]] = distance;
        }
    }
}

void kNearestNeighbours(int current, int counter, Location *prev, Cluster *cluster)
{
    if (current < cluster->locations.size())
    {
        int index;
        double min = DBL_MAX, distance;
        for (int i = 0; i < cluster->locations.size(); i++)
        {
            if (cluster->route[cluster->locations[i]] == 0)
            {
                cout << counter++ << " ";
                distance = euclidienDistance(prev->point, cluster->locations[i]->point);

                if (min > distance)
                {
                    min = distance;
                    index = i;
                }
            }
        }
        current++;
        cluster->distance += distance;
        cluster->route[cluster->locations[index]] = current;
        kNearestNeighbours(current, counter, cluster->locations[index], cluster);
    }
}

void kOptOptimization(Cluster *cluster)
{
    int n = cluster->sortedRoute.size();
    double distance = cluster->distance;
    // cout << "n = " << n << endl;
    for (int i = 1; i < n - 1; i++)
    {
        // cout << "i = (" << i << ", " << i + 1 << ")" << endl;
        distance = cluster->distance;
        for (int j = i + 2; j < (i > 1 ? n + 1 : n); j++)
        {
            // cout << "j = (" << j << ", " << (j == n ? 1 : j + 1) << ")" << endl;
            distance -= distances[cluster->sortedRoute[i]][cluster->sortedRoute[i + 1]];
            distance -= distances[cluster->sortedRoute[j]][cluster->sortedRoute[j == n ? 1 : j + 1]];

            distance += distances[cluster->sortedRoute[i]][cluster->sortedRoute[j]];
            distance += distances[cluster->sortedRoute[i + 1]][cluster->sortedRoute[j == n ? 1 : j + 1]];
            // cout << "New distance = " << distance << endl;
            if (cluster->distance > distance)
            {
                Location *temp = cluster->sortedRoute[i + 1];
                cluster->sortedRoute[i + 1] = cluster->sortedRoute[j];
                cluster->sortedRoute[j] = temp;
                cluster->distance = distance;
                cout << "Found better route with new distance = " << distance << "!\n"
                     << endl;
                kOptOptimization(cluster);
                return;
            }
        }
    }
}

// Written by Akshay Vhatkar on 20/03/2023
// EOF.