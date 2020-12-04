#include <fstream>
#include <string>
#include <vector>

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
    int collisions = 0;
    // this is shameful but i'm not changing it, to remind myself to think better next time
    int displacement = -3; // to start at (0,0)
    for (const auto& s : grid)
    {
        displacement += 3;
        displacement %= s.length();
        collisions += s[displacement] == '#';
    }
    std::cout << collisions << std::endl;
}