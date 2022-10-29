/*
Student Name - M.R.T.T Bandara
UoW ID - W1761298
IIT ID - 2019356
*/

import java.util.Arrays;
import java.util.LinkedList;

public class MaximumFlow {

    static final int V = DataStructure.numberOfNodes;              // Number of vertices in graph


    boolean bfs(int[][] rGraph, int s, int t, int[] parent) {       // Returns true if there is a path from source to sink in residual graph. Also fills parent[] to store the path

        boolean[] visited = new boolean[V];             // Creating a visited array

        for (int i = 0; i < V; ++i) {               // Marking all vertices as not visited
            visited[i] = false;
        }


        LinkedList<Integer> queue = new LinkedList<>();     // Creating a queue, enqueue source vertex and mark source vertex as visited
        queue.add(s);
        visited[s] = true;
        parent[s] = -1;


        while (queue.size() != 0) {                  // Standard BFS Loop

            int u = queue.poll();               // Removing the first element from the queue

            for (int v = 0; v < V; v++) {

                if (!visited[v] && rGraph[u][v] > 0) {      // If a connection to the sink node is found, its parent will be set and return true

                    if (v == t) {
                        parent[v] = u;

                        System.out.println(Arrays.toString(parent));
                        return true;            // Return true when the path reaches sink from the source


                    }
                    queue.add(v);
                    parent[v] = u;
                    visited[v] = true;
                }
            }
        }
        return false;     // Return false when the path does not reach sink from the source
    }


    public int fordFulkerson(int[][] graph, int s, int t) {

        int u, v;


        int[][] rGraph = new int[V][V];                // Creating a residual graph

        for (u = 0; u < V; u++) {                // Filling the residual graph with given capacities in the original graph as residual capacities
            for (v = 0; v < V; v++) {
                rGraph[u][v] = graph[u][v];
            }
        }


        int[] parent = new int[V];                       // This array is filled by BFS and stores path
        int maxFlow = 0;                              // The initial flow is zero

        while (bfs(rGraph, s, t, parent)) {                         // Augment the flow while there is path from source to sink

            int pathFlow = Integer.MAX_VALUE;                    // Find minimum residual capacity of the edges

            for (v = t; v != s; v = parent[v]) {                      // along the path filled by BFS.
                u = parent[v];
                pathFlow = Math.min(pathFlow, rGraph[u][v]);          // find the maximum flow through the path found.
                System.out.println(pathFlow);
            }

            for (v = t; v != s; v = parent[v]) {            // update residual capacities of the edges and reverse edges along the path
                u = parent[v];
                rGraph[u][v] -= pathFlow;
                rGraph[v][u] += pathFlow;
            }

            System.out.println("* Path flow value - " + pathFlow);       // Printing the incremental values (pathFlow) that calculate the max Flow for a single path

            maxFlow += pathFlow;                       // Add path flow to overall flow
        }

        return maxFlow;                              // Return the overall flow (Max Flow)
    }
}


/*
     References:

     * Ford Fulkerson Algorithm Explanations:

            * https://en.wikipedia.org/wiki/Ford%E2%80%93Fulkerson_algorithm
            * https://en.wikipedia.org/wiki/Maximum_flow_problem
            * Lecture Notes
            * Tutorial Notes

     * Ford Fulkerson Code Implementation:

            * https://www.geeksforgeeks.org/ford-fulkerson-algorithm-for-maximum-flow-problem/
            * Lecture Notes
            * Tutorial Notes
*/