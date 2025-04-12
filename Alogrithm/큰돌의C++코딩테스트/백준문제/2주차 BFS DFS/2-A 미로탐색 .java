import java.util.*;
import java.io.*;

public class Main {

    static int n, m;
    static int[][] myMap;
    static int[][] visited;
    static int[] dy = {-1, 1, 0, 0};
    static int[] dx = {0, 0, -1, 1};

    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        String input = br.readLine();
        String[] splits = input.split(" ");

        n = Integer.parseInt(splits[0]);
        m = Integer.parseInt(splits[1]);

        myMap = new int[n][m];
        visited = new int[n][m];

        for (int i = 0; i < n; i++) {
            String line = br.readLine();
            for (int j = 0; j < m; j++) {
                myMap[i][j] = line.charAt(j) - '0';
            }
        }

        bfs();
        System.out.println(visited[n-1][m-1]);
    }

    static void bfs() {
        Queue<Point> q = new LinkedList<>();

        visited[0][0] = 1;
        q.add(new Point(0, 0));

        while(!q.isEmpty()) {
            Point curr =  q.poll();
            int y = curr.y;
            int x = curr.x;
            for (int dir = 0; dir < 4; dir++) {
                int ny = y + dy[dir];
                int nx = x + dx[dir];

                if (ny < 0 || ny >= n || nx < 0 || nx >= m) continue;
                if (visited[ny][nx] > 0 || myMap[ny][nx] == 0) continue;

                visited[ny][nx] = visited[y][x] + 1;
                q.offer(new Point(ny, nx));
            }
        }
    }
}

class Point {
    int y, x;
    Point (int y, int x) {
        this.y = y;
        this.x = x;
    }
}