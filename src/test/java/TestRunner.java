import com.intuit.karate.junit5.Karate;

class TestRunner {


    @Karate.Test
    Karate testSystemProperty() {
        return Karate.run("classpath:employees/Get.feature");

    }
}