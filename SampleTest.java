package sameple;

class SampleTest {
    @Sample
    public void notATestMethod() throws Exception {
        System.out.println("Not a test method");
    }

    @Test
    public void testMethod1() throws Exception {
        System.out.println("Test method 1");
    }

    @Test
    public void testMethod2() throws Exception {
        System.out.println("Test method 2");
    }
}
