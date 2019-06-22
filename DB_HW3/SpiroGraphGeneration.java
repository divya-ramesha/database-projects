import java.io. * ;
import java.util. * ;
import java.math. * ;

/*
javac SpiroGraphGeneration.java
java SpiroGraphGeneration
*/
public class SpiroGraphGeneration {

    public static void main(String[] args) throws IOException {

        FileWriter fw = new FileWriter("spiro.kml");

        fw.write("<?xml version='1.0' encoding='UTF-8'?>\n<kml xmlns='http://earth.google.com/kml/2.0'>\n<Document>\n<Placemark>\n<name>SGM Hall</name>\n<Point>\n<coordinates>\n-118.28915,34.02122\n</coordinates>\n</Point>\n</Placemark>\n<Placemark>\n<name>\nSpirograph\n</name>\n<LineString>\n<coordinates>\n");
        LinkedHashMap<Double, String> map = new LinkedHashMap<Double,String>();
        double R = 8.00, r = 1.00, a = 4.00;

        double xpoint, ypoint, longitude, latitude;
        double lo = -118.28915, la = 34.02122, nRev = 16;

        for (double t = 0.00; t <= (Math.PI * nRev); t += 0.01) {
            xpoint = (R + r) * Math.cos((r / R) * t) - a * Math.cos((1 + r / R) * t);
            ypoint = (R + r) * Math.sin((r / R) * t) - a * Math.sin((1 + r / R) * t);
            longitude = (lo + 0.0001 * ypoint);
            latitude = (la + 0.0001 * xpoint);
            map.put(t, longitude + "," + latitude);

        }

        for (Double key: map.keySet()) {
            fw.write(map.get(key) + "\n");
            // System.out.println(map.get(key)+"\n");
        }
        fw.write("</coordinates>\n</LineString>\n<Style>\n<LineStyle>\n<width>\n9\n</width>\n<color>\nff0000ff\n</color>\n</LineStyle>\n</Style>\n</Placemark>\n</Document>\n</kml>");

        fw.close();
    }

}