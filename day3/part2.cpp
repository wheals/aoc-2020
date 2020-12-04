#include <fstream>
#include <string>
#include <vector>
#include <array>
#include <iostream>

int main()
{
    std::ifstream input{"input.txt"};
    std::vector<std::string> grid;
    while (input.good())
    {
        std::string line;
        input >> line;
        grid.emplace_back(line);
    }
    long product = 1;
    for (const auto& displacements : std::array<std::array<int, 2>, 5>{{ { 1, 1 }, { 3, 1 }, { 5, 1 }, { 7, 1 }, { 1, 2 } }})
    {
        const int dx = displacements[0], dy = displacements[1];
        int x = 0, y = 0;
        int collisions = 0;
        do
        {
            x += dx;
            x %= grid[0].length();

            y += dy;
            collisions += grid[y][x] == '#';
        } while (y < (int)grid.size() - 1);
        product *= collisions;
    }
    std::cout << product << std::endl;
}