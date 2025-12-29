// https://github.com/sevenc-nanashi/nanacpp
#ifndef ONLINE_JUDGE
#define _GLIBCXX_DEBUG 1
#endif


// ----- features/core.hpp -----

#include <bits/stdc++.h>

using namespace std;

#define fn auto
#define let auto

#define each(x, a) for (auto &x : a)
#define each1(x, a) for (auto &x : a)
#define each2(x, y, a) for (auto &[x, y] : a)
#define each3(x, y, z, a) for (auto &[x, y, z] : a)
#define each4(w, x, y, z, a) for (auto &[w, x, y, z] : a)

#define enumerate(x, i, a)                                                     \
  for (usize i = 0; i < (usize)a.size(); ++i)                                  \
    if (auto &x = a[i]; true)
#define enumerate1(x, i, a)                                                    \
  for (usize i = 0; i < (usize)a.size(); ++i)                                  \
    if (auto &x = a[i]; true)
#define enumerate2(x, y, i, a)                                                 \
  usize i = 0;                                                                 \
  for (auto it = a.begin(); it != a.end(); ++it, ++i)                          \
    if (auto &[x, y] = *it; true)
#define enumerate3(x, y, z, i, a)                                              \
  usize i = 0;                                                                 \
  for (auto it = a.begin(); it != a.end(); ++it, ++i)                          \
    if (auto &[x, y, z] = *it; true)
#define enumerate4(w, x, y, z, i, a)                                           \
  usize i = 0;                                                                 \
  for (auto it = a.begin(); it != a.end(); ++it, ++i)                          \
    if (auto &[w, x, y, z] = *it; true)

#define rep(i, a) for (int i = 0; i < (a); ++i)
#define range(i, l, r) for (int i = (l); i < (r); ++i)
#define rangei(i, l, r) for (int i = (l); i <= (r); ++i)

#define chmax(var, val) var = std::max(var, val)
#define chmin(var, val) var = std::min(var, val)

#define all(x) begin(x), end(x)
#define rall(x) rbegin(x), rend(x)
#define sz(x) ((int)(x).size())

using ll = long long;
using i8 = int8_t;
using i16 = int16_t;
using i32 = int32_t;
using i64 = int64_t;
using isize = std::make_signed<std::size_t>::type;
using u8 = uint8_t;
using u16 = uint16_t;
using u32 = uint32_t;
using u64 = uint64_t;
using usize = std::make_unsigned<std::size_t>::type;

// ----- features/pair.hpp -----


template <typename T, typename U> class hpair {
public:
  T first;
  U second;
  hpair() = default;
  hpair(const T &f, const U &s) : first(f), second(s) {}
  bool operator==(const hpair<T, U> &other) const {
    return first == other.first && second == other.second;
  }
};

namespace std {
template <typename T, typename U> struct hash<hpair<T, U>> {
  size_t operator()(const hpair<T, U> &p) const {
    return hash<T>()(p.first) ^ (hash<U>()(p.second) << 1);
  }
};
} // namespace std

// ----- features/input.hpp -----


#define input(type, var)                                                       \
  type var;                                                                    \
  cin >> var;
#define input_vec(type, var, n)                                                \
  std::vector<type> var(n);                                                    \
  for (usize i = 0; i < (usize)(n); ++i) {                                     \
    cin >> var[i];                                                             \
  }
#define input_array(type, var, n)                                              \
  std::array<type, n> var;                                                     \
  for (usize i = 0; i < (usize)(n); ++i) {                                     \
    cin >> var[i];                                                             \
  }
#define input_pair(type1, type2, var)                                          \
  std::pair<type1, type2> var;                                                 \
  cin >> var.first >> var.second;
#define input_hpair(type1, type2, var)                                         \
  hpair<type1, type2> var;                                                     \
  cin >> var.first >> var.second;
#define input_vec_pair(type1, type2, var, n)                                   \
  std::vector<std::pair<type1, type2>> var(n);                                 \
  for (usize i = 0; i < (usize)(n); ++i) {                                     \
    cin >> var[i].first >> var[i].second;                                      \
  }
#define input_vec_hpair(type1, type2, var, n)                                  \
  std::vector<hpair<type1, type2>> var(n);                                     \
  for (usize i = 0; i < (usize)(n); ++i) {                                     \
    cin >> var[i].first >> var[i].second;                                      \
  }

// ----- features/debug.hpp -----


template <typename T>
std::ostream &operator<<(std::ostream &os, const std::vector<T> &v) {
  os << "[";
  for (usize i = 0; i < v.size(); ++i) {
    os << v[i];
    if (i + 1 != v.size()) {
      os << ", ";
    }
  }
  os << "]";
  return os;
}

template <typename T>
std::ostream &operator<<(std::ostream &os, const std::set<T> &v) {
  os << "{";
  for (auto it = v.begin(); it != v.end(); ++it) {
    os << *it;
    auto next_it = it;
    ++next_it;
    if (next_it != v.end()) {
      os << " ";
    }
  }
  os << "}";
  return os;
}

template <typename T>
std::ostream &operator<<(std::ostream &os, const std::unordered_set<T> &v) {
  os << "{";
  for (auto it = v.begin(); it != v.end(); ++it) {
    os << *it;
    auto next_it = it;
    ++next_it;
    if (next_it != v.end()) {
      os << " ";
    }
  }
  os << "}";
  return os;
}

template <typename T, typename U>
std::ostream &operator<<(std::ostream &os, const std::pair<T, U> &p) {
  os << "(" << p.first << ", " << p.second << ")";
  return os;
}

template <typename T, typename U>
std::ostream &operator<<(std::ostream &os, const std::map<T, U> &m) {
  os << "{";
  for (auto it = m.begin(); it != m.end(); ++it) {
    os << it->first << ": " << it->second;
    auto next_it = it;
    ++next_it;
    if (next_it != m.end()) {
      os << ", ";
    }
  }
  os << "}";
  return os;
}

template <typename T, typename U>
std::ostream &operator<<(std::ostream &os, const std::unordered_map<T, U> &m) {
  os << "{";
  for (auto it = m.begin(); it != m.end(); ++it) {
    os << it->first << ": " << it->second;
    auto next_it = it;
    ++next_it;
    if (next_it != m.end()) {
      os << ", ";
    }
  }
  os << "}";
  return os;
}

#ifdef ONLINE_JUDGE
#define dbg(x) x
#define dbg2(x) x
#define dbg3(x) x
#else
#define dbg(x)                                                                 \
  ([&]() {                                                                     \
    auto _dbg_x = (x);                                                         \
    std::cerr << "[dbg L" << __LINE__ << "] " << #x << " = ";                  \
    std::cerr << _dbg_x << std::endl;                                          \
    return _dbg_x;                                                             \
  }())
#define dbg2(x)                                                                \
  ([&]() {                                                                     \
    auto _dbg_x = (x);                                                         \
    std::cerr << "[[dbg L" << __LINE__ << "]] " << #x << " = ";                \
    std::cerr << _dbg_x << std::endl;                                          \
    return _dbg_x;                                                             \
  }())
#define dbg3(x)                                                                \
  ([&]() {                                                                     \
    auto _dbg_x = (x);                                                         \
    std::cerr << "[[[dbg L" << __LINE__ << "]]] " << #x << " = ";              \
    std::cerr << _dbg_x << std::endl;                                          \
    return _dbg_x;                                                             \
  }())
#endif

// ----- features/array_sum.hpp -----


template <typename T> class ArraySum {
private:
  usize n;
  std::vector<T> prefix_sum;

public:
  explicit ArraySum(const std::vector<T> &data)
      : n(data.size()), prefix_sum(n + 1, 0) {
    for (usize i = 0; i < n; ++i) {
      prefix_sum[i + 1] = prefix_sum[i] + data[i];
    }
  }

  /// 区間 [l, r) の和を返す
  T sum(size_t l, size_t r) const { return prefix_sum[r] - prefix_sum[l]; }

  /// 区間 [l, r] の和を返す
  T sum_closed(size_t l, size_t r) const {
    return prefix_sum[r + 1] - prefix_sum[l];
  }
};

// ----- features/bisect.hpp -----


template <typename F>
/// Finds the first index `i` in the half-open range `[l, r)` such that
/// `cond(i)` is true. If no such index exists, returns `r`.
i64 bisect_first(i64 l, i64 r, F &&cond) {
  i64 left = l - 1;
  i64 right = r;
  while (left + 1 < right) {
    i64 mid = left + (right - left) / 2;
    if (cond(mid)) {
      right = mid;
    } else {
      left = mid;
    }
  }
  return right;
}

template <typename F>
/// Finds the first index `i` in the closed range `[l, r]` such that
/// `cond(i)` is true. If no such index exists, returns `r + 1`.
i64 bisect_first_closed(i64 l, i64 r, F &&cond) {
  i64 left = l;
  i64 right = r + 1;
  while (left < right) {
    i64 mid = left + (right - left) / 2;
    if (cond(mid)) {
      right = mid;
    } else {
      left = mid + 1;
    }
  }
  return left;
}

template <typename F>
/// Finds the last index `i` in the half-open range `[l, r)` such that
/// `cond(i)` is true. If no such index exists, returns `l - 1`.
i64 bisect_last(i64 l, i64 r, F &&cond) {
  i64 left = l - 1;
  i64 right = r;
  while (left + 1 < right) {
    i64 mid = left + (right - left) / 2;
    if (cond(mid)) {
      left = mid;
    } else {
      right = mid;
    }
  }
  return left;
}

template <typename F>
/// Finds the last index `i` in the closed range `[l, r]` such that
/// `cond(i)` is true. If no such index exists, returns `l - 1`.
i64 bisect_last_closed(i64 l, i64 r, F &&cond) {
  i64 left = l - 1;
  i64 right = r;
  while (left < right) {
    i64 mid = left + (right - left + 1) / 2;
    if (cond(mid)) {
      left = mid;
    } else {
      right = mid - 1;
    }
  }
  return left;
}

// ----- features/imos.hpp -----


// Imos 法（差分配列）を扱うユーティリティ
template <typename T> class Imos {
private:
  std::vector<T> diff;
  std::vector<T> built_values;
  bool ready;

public:
  explicit Imos(usize n) : diff(n + 1, 0), built_values(n, 0), ready(false) {}

  usize size() const { return built_values.size(); }

  // 区間 [l, r) に value を加算する
  void add(usize l, usize r, const T &value) {
    assert(l <= r);
    assert(l <= size());
    assert(r <= size());
    diff[l] += value;
    diff[r] -= value;
    ready = false;
  }

  // 区間 [l, r] に value を加算する
  void add_closed(usize l, usize r, const T &value) {
    assert(l <= r);
    assert(r < size());
    add(l, r + 1, value);
  }

  [[nodiscard]] const std::vector<T> &build() {
    if (!ready) {
      T run = 0;
      for (usize i = 0; i < size(); ++i) {
        run += diff[i];
        built_values[i] = run;
      }
      ready = true;
    }
    return built_values;
  }

  [[nodiscard]] const std::vector<T> &values() const {
    assert(ready);
    return built_values;
  }

  [[nodiscard]] const T &operator[](usize idx) const {
    assert(ready);
    return built_values[idx];
  }

  std::vector<T> applied(std::vector<T> base) {
    assert(base.size() == size());
    const auto &delta = build();
    for (usize i = 0; i < size(); ++i) {
      base[i] += delta[i];
    }
    return base;
  }
};

// ----- features/tally.hpp -----


template <typename T> std::map<T, u64> tally(const std::vector<T> &data) {
  std::map<T, u64> counts;
  for (const auto &item : data) {
    counts[item]++;
  }
  return counts;
}


// ----- main.cpp -----

fn main() -> int {
  cin.tie(0)->sync_with_stdio(0);
  cout << fixed << setprecision(15);

  // your code here...
}
