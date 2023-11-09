package singleton;

public class SettingsV1 {

    private static SettingsV1 instance;

    // new를 사용하지 못하게끔 private 접근제어자로~
    private SettingsV1() {}

    /**
     * Settings 인트턴스생성없이 정적클래스로
     * 단점) 멀티쓰레드 환경에서 서로 다른 Settings객체가 생성될 위험존재
      *dfdf/
    public static SettingsV1 getInstance() {
        if (instance == null) {
            instance = new SettingsV1();
            return instance;
        }
        return instance;
    }

    /**
     * synchronized 키워드 덕분에 한 스레드가
     * 장점) 멀티쓰레드 환경에서도 단일 객체만 생성되는 것을 보장받을 수 있다
     *      이유: 스레드 1개만 접근하도록 허락하기 때문에
     * 단점) 성능저하 이유. 동기화메커니즘이 락을 사용하기 때문
     */
    public static synchronized SettingsV1 getInstanceSync() {
        if (instance == null) {
            instance = new SettingsV1();
        }
        return instance;
    }
}
