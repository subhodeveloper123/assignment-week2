import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import mockexcerise_1.ExternalApi;
import mockexcerise_1.MyService;
public class MyServiceTest {

    @Test
    public void testExternalApi() {
        // Step 1: Create mock
        ExternalApi mockApi = Mockito.mock(ExternalApi.class);

        // Step 2: Stub method
        when(mockApi.getData()).thenReturn("Mock Data");

        // Step 3: Inject mock into service
        MyService service = new MyService(mockApi);

        // Step 4: Assert expected result
        String result = service.fetchData();
        assertEquals("Mock Data", result);
    }
}
