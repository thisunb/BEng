
package server;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the server package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _Exception_QNAME = new QName("http://server/", "Exception");
    private final static QName _ShortestString_QNAME = new QName("http://server/", "shortestString");
    private final static QName _GetSmallestIntegerResponse_QNAME = new QName("http://server/", "getSmallestIntegerResponse");
    private final static QName _AddIntegerOnServer_QNAME = new QName("http://server/", "addIntegerOnServer");
    private final static QName _GetSmallestInteger_QNAME = new QName("http://server/", "getSmallestInteger");
    private final static QName _AddIntegerOnServerResponse_QNAME = new QName("http://server/", "addIntegerOnServerResponse");
    private final static QName _TestConnection_QNAME = new QName("http://server/", "testConnection");
    private final static QName _TestConnectionResponse_QNAME = new QName("http://server/", "testConnectionResponse");
    private final static QName _SafeShortestStringResponse_QNAME = new QName("http://server/", "safeShortestStringResponse");
    private final static QName _Hello_QNAME = new QName("http://server/", "hello");
    private final static QName _GetAllIntegerSamplesBelowResponse_QNAME = new QName("http://server/", "getAllIntegerSamplesBelowResponse");
    private final static QName _SafeShortestString_QNAME = new QName("http://server/", "safeShortestString");
    private final static QName _HelloResponse_QNAME = new QName("http://server/", "helloResponse");
    private final static QName _GetAllIntegerSamplesBelow_QNAME = new QName("http://server/", "getAllIntegerSamplesBelow");
    private final static QName _ShortestStringResponse_QNAME = new QName("http://server/", "shortestStringResponse");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: server
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link TestConnection }
     * 
     */
    public TestConnection createTestConnection() {
        return new TestConnection();
    }

    /**
     * Create an instance of {@link AddIntegerOnServerResponse }
     * 
     */
    public AddIntegerOnServerResponse createAddIntegerOnServerResponse() {
        return new AddIntegerOnServerResponse();
    }

    /**
     * Create an instance of {@link AddIntegerOnServer }
     * 
     */
    public AddIntegerOnServer createAddIntegerOnServer() {
        return new AddIntegerOnServer();
    }

    /**
     * Create an instance of {@link GetSmallestInteger }
     * 
     */
    public GetSmallestInteger createGetSmallestInteger() {
        return new GetSmallestInteger();
    }

    /**
     * Create an instance of {@link GetSmallestIntegerResponse }
     * 
     */
    public GetSmallestIntegerResponse createGetSmallestIntegerResponse() {
        return new GetSmallestIntegerResponse();
    }

    /**
     * Create an instance of {@link Exception }
     * 
     */
    public Exception createException() {
        return new Exception();
    }

    /**
     * Create an instance of {@link ShortestString }
     * 
     */
    public ShortestString createShortestString() {
        return new ShortestString();
    }

    /**
     * Create an instance of {@link ShortestStringResponse }
     * 
     */
    public ShortestStringResponse createShortestStringResponse() {
        return new ShortestStringResponse();
    }

    /**
     * Create an instance of {@link HelloResponse }
     * 
     */
    public HelloResponse createHelloResponse() {
        return new HelloResponse();
    }

    /**
     * Create an instance of {@link GetAllIntegerSamplesBelow }
     * 
     */
    public GetAllIntegerSamplesBelow createGetAllIntegerSamplesBelow() {
        return new GetAllIntegerSamplesBelow();
    }

    /**
     * Create an instance of {@link GetAllIntegerSamplesBelowResponse }
     * 
     */
    public GetAllIntegerSamplesBelowResponse createGetAllIntegerSamplesBelowResponse() {
        return new GetAllIntegerSamplesBelowResponse();
    }

    /**
     * Create an instance of {@link SafeShortestString }
     * 
     */
    public SafeShortestString createSafeShortestString() {
        return new SafeShortestString();
    }

    /**
     * Create an instance of {@link SafeShortestStringResponse }
     * 
     */
    public SafeShortestStringResponse createSafeShortestStringResponse() {
        return new SafeShortestStringResponse();
    }

    /**
     * Create an instance of {@link Hello }
     * 
     */
    public Hello createHello() {
        return new Hello();
    }

    /**
     * Create an instance of {@link TestConnectionResponse }
     * 
     */
    public TestConnectionResponse createTestConnectionResponse() {
        return new TestConnectionResponse();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Exception }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server/", name = "Exception")
    public JAXBElement<Exception> createException(Exception value) {
        return new JAXBElement<Exception>(_Exception_QNAME, Exception.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ShortestString }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server/", name = "shortestString")
    public JAXBElement<ShortestString> createShortestString(ShortestString value) {
        return new JAXBElement<ShortestString>(_ShortestString_QNAME, ShortestString.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetSmallestIntegerResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server/", name = "getSmallestIntegerResponse")
    public JAXBElement<GetSmallestIntegerResponse> createGetSmallestIntegerResponse(GetSmallestIntegerResponse value) {
        return new JAXBElement<GetSmallestIntegerResponse>(_GetSmallestIntegerResponse_QNAME, GetSmallestIntegerResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link AddIntegerOnServer }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server/", name = "addIntegerOnServer")
    public JAXBElement<AddIntegerOnServer> createAddIntegerOnServer(AddIntegerOnServer value) {
        return new JAXBElement<AddIntegerOnServer>(_AddIntegerOnServer_QNAME, AddIntegerOnServer.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetSmallestInteger }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server/", name = "getSmallestInteger")
    public JAXBElement<GetSmallestInteger> createGetSmallestInteger(GetSmallestInteger value) {
        return new JAXBElement<GetSmallestInteger>(_GetSmallestInteger_QNAME, GetSmallestInteger.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link AddIntegerOnServerResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server/", name = "addIntegerOnServerResponse")
    public JAXBElement<AddIntegerOnServerResponse> createAddIntegerOnServerResponse(AddIntegerOnServerResponse value) {
        return new JAXBElement<AddIntegerOnServerResponse>(_AddIntegerOnServerResponse_QNAME, AddIntegerOnServerResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link TestConnection }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server/", name = "testConnection")
    public JAXBElement<TestConnection> createTestConnection(TestConnection value) {
        return new JAXBElement<TestConnection>(_TestConnection_QNAME, TestConnection.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link TestConnectionResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server/", name = "testConnectionResponse")
    public JAXBElement<TestConnectionResponse> createTestConnectionResponse(TestConnectionResponse value) {
        return new JAXBElement<TestConnectionResponse>(_TestConnectionResponse_QNAME, TestConnectionResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link SafeShortestStringResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server/", name = "safeShortestStringResponse")
    public JAXBElement<SafeShortestStringResponse> createSafeShortestStringResponse(SafeShortestStringResponse value) {
        return new JAXBElement<SafeShortestStringResponse>(_SafeShortestStringResponse_QNAME, SafeShortestStringResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Hello }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server/", name = "hello")
    public JAXBElement<Hello> createHello(Hello value) {
        return new JAXBElement<Hello>(_Hello_QNAME, Hello.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetAllIntegerSamplesBelowResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server/", name = "getAllIntegerSamplesBelowResponse")
    public JAXBElement<GetAllIntegerSamplesBelowResponse> createGetAllIntegerSamplesBelowResponse(GetAllIntegerSamplesBelowResponse value) {
        return new JAXBElement<GetAllIntegerSamplesBelowResponse>(_GetAllIntegerSamplesBelowResponse_QNAME, GetAllIntegerSamplesBelowResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link SafeShortestString }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server/", name = "safeShortestString")
    public JAXBElement<SafeShortestString> createSafeShortestString(SafeShortestString value) {
        return new JAXBElement<SafeShortestString>(_SafeShortestString_QNAME, SafeShortestString.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link HelloResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server/", name = "helloResponse")
    public JAXBElement<HelloResponse> createHelloResponse(HelloResponse value) {
        return new JAXBElement<HelloResponse>(_HelloResponse_QNAME, HelloResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetAllIntegerSamplesBelow }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server/", name = "getAllIntegerSamplesBelow")
    public JAXBElement<GetAllIntegerSamplesBelow> createGetAllIntegerSamplesBelow(GetAllIntegerSamplesBelow value) {
        return new JAXBElement<GetAllIntegerSamplesBelow>(_GetAllIntegerSamplesBelow_QNAME, GetAllIntegerSamplesBelow.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ShortestStringResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server/", name = "shortestStringResponse")
    public JAXBElement<ShortestStringResponse> createShortestStringResponse(ShortestStringResponse value) {
        return new JAXBElement<ShortestStringResponse>(_ShortestStringResponse_QNAME, ShortestStringResponse.class, null, value);
    }

}
