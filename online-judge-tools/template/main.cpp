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
#define enumerate1(x, i, a)                                                  \
  for (usize i = 0; i < (usize)a.size(); ++i)                                  \
    if (auto &x = a[i]; true)
#define enumerate2(x, y, i, a)                                                \
  usize i = 0;                                                                 \
  for (auto it = a.begin(); it != a.end(); ++it, ++i)                          \
    if (auto &[x, y] = *it; true)
#define enumerate3(x, y, z, i, a)                                             \
  usize i = 0;                                                                 \
  for (auto it = a.begin(); it != a.end(); ++it, ++i)                          \
    if (auto &[x, y, z] = *it; true)
#define enumerate4(w, x, y, z, i, a)                                          \
  usize i = 0;                                                                 \
  for (auto it = a.begin(); it != a.end(); ++it, ++i)                          \
    if (auto &[w, x, y, z] = *it; true)

#define rep(i, a) for (int i = 0; i < (a); ++i)
#define range(i, l, r) for (int i = (l); i < (r); ++i)
#define rangei(i, l, r) for (int i = (l); i <= (r); ++i)

#define all(x) begin(x), end(x)
#define rall(x) rbegin(x), rend(x)
#define sz(x) ((int)(x).size())

// ----- features/int.hpp -----

#include <cstdint>
#include <type_traits>

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
std::ostream &operator<<(std::ostream &os,
                          const std::unordered_map<T, U> &m) {
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
    std::cerr << "[dbg L" << __LINE__ << "] " << #x << " = ";                  \
    auto _dbg_x = (x);                                                         \
    std::cerr << _dbg_x << std::endl;                                          \
    return _dbg_x;                                                             \
  }())
#define dbg2(x)                                                                \
  ([&]() {                                                                     \
    std::cerr << "[[dbg L" << __LINE__ << "]] " << #x << " = ";                  \
    auto _dbg_x = (x);                                                         \
    std::cerr << _dbg_x << std::endl;                                          \
    return _dbg_x;                                                             \
  }())
#define dbg3(x)                                                                \
  ([&]() {                                                                     \
    std::cerr << "[[[dbg L" << __LINE__ << "]]] " << #x << " = ";                  \
    auto _dbg_x = (x);                                                         \
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
  explicit ArraySum(const std::vector<T> &data) : n(data.size()), prefix_sum(n + 1, 0) {
    for (usize i = 0; i < n; ++i) {
      prefix_sum[i + 1] = prefix_sum[i] + data[i];
    }
  }

  T sum(size_t l, size_t r) const { return prefix_sum[r] - prefix_sum[l]; }
};


// ----- features/bisect.hpp -----


template <typename F>
u64 bisect_first(u64 l, u64 r, F &&cond) {
  while (l < r) {
    u64 m = (l + r) / 2;
    if (cond(m)) {
      r = m;
    } else {
      l = m + 1;
    }
  }
  return l;
}

template <typename F>
u64 bisect_last(u64 l, u64 r, F &&cond) {
  while (l < r) {
    u64 m = (l + r) / 2;
    if (cond(m)) {
      l = m + 1;
    } else {
      r = m;
    }
  }
  return l - 1;
}


// ----- features/tally.hpp -----


template <typename T> std::map<T, u64> tally(const std::vector<T> &data) {
  std::map<T, u64> counts;
  for (const auto &item : data) {
    counts[item]++;
  }
  return counts;
}

// ! end features

fn main() -> int {
  cin.tie(0)->sync_with_stdio(0);
  cout << fixed << setprecision(15);

  // your code here...
}
