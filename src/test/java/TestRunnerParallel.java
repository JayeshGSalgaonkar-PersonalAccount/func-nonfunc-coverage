import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import cucumber.api.CucumberOptions;
import org.junit.jupiter.api.Test;

class TestRunnerParallel {

    @Test
    void apiFunctionalTest() {
        Results results = Runner.path("classpath:ntuc_memberportal/FeatureFiles/")
                .parallel(37);
    }
}
