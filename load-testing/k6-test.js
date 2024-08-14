export let options = {
  stages: [
    { duration: "2m", target: 100 }, // ramp up to 100 users
    { duration: "5m", target: 100 }, // stay at 100 users
    { duration: "2m", target: 200 }, // ramp up to 200 users
    { duration: "5m", target: 200 }, // stay at 200 users
    { duration: "2m", target: 500 }, // ramp up to 500 users
    { duration: "5m", target: 500 }, // stay at 500 users
    { duration: "2m", target: 1000 }, // ramp up to 1000 users
    { duration: "5m", target: 1000 }, // stay at 1000 users
    { duration: "5m", target: 0 }, // ramp down to 0 users
  ],
  thresholds: {
    http_req_duration: ["p(95)<500"], // 95% of requests must complete below 500ms
  },
};

export default function () {
  let res = http.get("http://your-load-balancer-url"); // Replace with your CORS proxy service URL
  check(res, {
    "status was 200": (r) => r.status == 200,
  });
  sleep(1);
}
