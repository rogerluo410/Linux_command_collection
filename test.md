1.Unit test: Specify and test one point of the contract of single method of a class.   
This should have a very narrow and well defined scope.   
Complex dependencies and interactions to the outside world are stubbed or mocked.   

2.Integration test: Test the correct inter-operation of multiple subsystems.    
There is whole spectrum there, from testing integration between two classes, to testing integration with the production environment.   

3.Smoke test: A simple integration test where we just check that when the system under test is invoked it returns normally and does not blow up.    
It is an analogy with electronics,where the first test occurs when powering up a circuit: if it smokes, it's bad.   

4.Regression test: A test that was written when a bug was fixed.   
It ensure that this specific bug will not occur again. The full name is "non-regression test".   

5.Acceptance test: Test that a feature or use case is correctly implemented.    
It is similar to an integration test, but with a focus on the use case to provide rather than on the components involved.  
