#include <iostream>
#include "module1.hpp"
#include "dir/module2.hpp"

using namespace std;

int main()
{
	cout << "Hello world !" << endl;
	modularity_check1();
	modularity_check2();
	return 0;
}
