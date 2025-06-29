import api.ExternalApi;
import api.MyService;

import org.junit.jupiter.api.Test;

import static org.mockito.Mockito.*;

public class MyServiceTest {

    @Test
    public void testVerifyInteraction() {
        // Step 1: Create mock
        ExternalApi mockApi = mock(ExternalApi.class);

        // Step 2: Inject mock into service
        MyService service = new MyService(mockApi);

        // Step 3: Call method
        service.fetchData();

        // Step 4: Verify the interaction
        verify(mockApi).getData();  // ✅ Test passes only if this method is called
    }
}
