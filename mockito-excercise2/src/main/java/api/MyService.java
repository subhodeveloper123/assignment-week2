package api;
import api.ExternalApi;



public class MyService {
    private final ExternalApi externalApi;

    public MyService(ExternalApi externalApi) {
        this.externalApi = externalApi;
    }

    public String fetchData() {
        return externalApi.getData(); // this call will be verified in test
    }
}
