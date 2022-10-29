
package server;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for safeShortestString complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="safeShortestString">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="s1" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="s2" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "safeShortestString", propOrder = {
    "s1",
    "s2"
})
public class SafeShortestString {

    protected String s1;
    protected String s2;

    /**
     * Gets the value of the s1 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getS1() {
        return s1;
    }

    /**
     * Sets the value of the s1 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setS1(String value) {
        this.s1 = value;
    }

    /**
     * Gets the value of the s2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getS2() {
        return s2;
    }

    /**
     * Sets the value of the s2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setS2(String value) {
        this.s2 = value;
    }

}
