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
#define sz(x) ((i64)(x).size())

using ll = long long;
using i8 = int8_t;
using i16 = int16_t;
using i32 = int32_t;
using i64 = int64_t;
using i128 = __int128;
using isize = std::make_signed<std::size_t>::type;
using u8 = uint8_t;
using u16 = uint16_t;
using u32 = uint32_t;
using u64 = uint64_t;
using u128 = __uint128_t;
using usize = std::make_unsigned<std::size_t>::type;

// ----- features/pair.hpp -----


/// `std::pair` のハッシュ対応版。
template <typename T, typename U> class hpair {
public:
  T first;
  U second;
  /// デフォルトコンストラクタ。
  hpair() = default;
  /// 値を受け取るコンストラクタ。
  hpair(const T &f, const U &s) : first(f), second(s) {}
  /// 等価比較。
  bool operator==(const hpair<T, U> &other) const {
    return first == other.first && second == other.second;
  }
};

namespace std {
/// `hpair` を unordered 系コンテナで使うためのハッシュ。
template <typename T, typename U> struct hash<hpair<T, U>> {
  size_t operator()(const hpair<T, U> &p) const {
    return hash<T>()(p.first) ^ (hash<U>()(p.second) << 1);
  }
};
} // namespace std

// ----- features/input.hpp -----


/// 1 変数を読み込む。
#define input(type, var)                                                       \
  type var;                                                                    \
  cin >> var;

/// 要素数 `n` のベクタを読み込む。
#define input_vec(type, var, n)                                                \
  std::vector<type> var(n);                                                    \
  for (usize i = 0; i < (usize)(n); ++i) {                                     \
    cin >> var[i];                                                             \
  }

/// 要素数固定の `std::array` を読み込む。
#define input_array(type, var, n)                                              \
  std::array<type, n> var;                                                     \
  for (usize i = 0; i < (usize)(n); ++i) {                                     \
    cin >> var[i];                                                             \
  }

/// 2 要素の `std::pair` を読み込む。
#define input_pair(type1, type2, var)                                          \
  std::pair<type1, type2> var;                                                 \
  cin >> var.first >> var.second;

/// 2 要素の `hpair` を読み込む。
#define input_hpair(type1, type2, var)                                         \
  hpair<type1, type2> var;                                                     \
  cin >> var.first >> var.second;

/// 要素数 `n` の `std::pair` ベクタを読み込む。
#define input_vec_pair(type1, type2, var, n)                                   \
  std::vector<std::pair<type1, type2>> var(n);                                 \
  for (usize i = 0; i < (usize)(n); ++i) {                                     \
    cin >> var[i].first >> var[i].second;                                      \
  }

/// 要素数 `n` の `hpair` ベクタを読み込む。
#define input_vec_hpair(type1, type2, var, n)                                  \
  std::vector<hpair<type1, type2>> var(n);                                     \
  for (usize i = 0; i < (usize)(n); ++i) {                                     \
    cin >> var[i].first >> var[i].second;                                      \
  }

// ----- features/debug.hpp -----

#include <string>

std::ostream &
operator<<(std::ostream &os, // NOLINT: いうて1ファイルにまとまるし...
           const u128 &v) {
  u128 temp = v;
  if (temp == 0) {
    os << '0';
    return os;
  }
  std::string digits;
  while (temp > 0) {
    digits.push_back(static_cast<char>('0' + (temp % 10)));
    temp /= 10;
  }
  std::reverse(digits.begin(), digits.end());
  os << digits;
  return os;
}

std::ostream &
operator<<(std::ostream &os, // NOLINT: いうて1ファイルにまとまるし...
           const i128 &v) {
  if (v >= 0) {
    return os << static_cast<u128>(v);
  } else {
    os << '-';
    return os << static_cast<u128>(-v);
  }
}

/// `std::vector` を可読なリスト形式で出力する。
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

/// `std::set` を空白区切りで出力する。
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

/// `std::unordered_set` を空白区切りで出力する。
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

/// `std::pair` を `(first, second)` 形式で出力する。
template <typename T, typename U>
std::ostream &operator<<(std::ostream &os, const std::pair<T, U> &p) {
  os << "(" << p.first << ", " << p.second << ")";
  return os;
}

/// `std::map` を `key: value` の並びで出力する。
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

/// `std::unordered_map` を `key: value` の並びで出力する。
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

/// ローカル実行時のみ変数を stderr に出力し、値をそのまま返すデバッグマクロ群。
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


/// 1 次元配列の累積和を保持し、区間和を高速に計算するヘルパー。
template <typename T> class ArraySum {
private:
  usize n;
  std::vector<T> prefix_sum;

public:
  /// `data` から累積和を構築する。計算量は O(N)。
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
/// 半開区間 `[l, r)` で `cond(i)` が真になる最初の `i` を返す。
/// 存在しなければ `std::nullopt` を返す。
std::optional<i64> bisect_first(i64 l, i64 r, F &&cond) {
  if (cond(l)) {
    return l;
  }
  if (!cond(r - 1)) {
    return std::nullopt;
  }

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
/// 閉区間 `[l, r]` で `cond(i)` が真になる最初の `i` を返す。
/// 存在しなければ `std::nullopt` を返す。
std::optional<i64> bisect_first_closed(i64 l, i64 r, F &&cond) {
  return bisect_first(l, r + 1, cond);
}

template <typename F>
/// 半開区間 `[l, r)` で `cond(i)` が真になる最後の `i` を返す。
/// 存在しなければ `std::nullopt` を返す。
std::optional<i64> bisect_last(i64 l, i64 r, F &&cond) {
  if (!cond(l)) {
    return std::nullopt;
  }
  if (cond(r - 1)) {
    return r - 1;
  }

  i64 left = l;
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
/// 閉区間 `[l, r]` で `cond(i)` が真になる最後の `i` を返す。
/// 存在しなければ `std::nullopt` を返す。
std::optional<i64> bisect_last_closed(i64 l, i64 r, F &&cond) {
  return bisect_last(l, r + 1, cond);
}

// ----- features/imos.hpp -----


/// Imos 法（差分配列）で区間加算をまとめて反映するユーティリティ。
template <typename T> class Imos {
private:
  std::vector<T> diff;
  std::vector<T> built_values;
  bool ready;

public:
  /// 要素数 `n` の差分配列を初期化する。
  explicit Imos(usize n) : diff(n + 1, 0), built_values(n, 0), ready(false) {}

  /// 配列の長さを返す。
  usize size() const { return built_values.size(); }

  /// 区間 [l, r) に `value` を加算する。
  void add(usize l, usize r, const T &value) {
    assert(l <= r);
    assert(l <= size());
    assert(r <= size());
    diff[l] += value;
    diff[r] -= value;
    ready = false;
  }

  /// 区間 [l, r] に `value` を加算する。
  void add_closed(usize l, usize r, const T &value) {
    assert(l <= r);
    assert(r < size());
    add(l, r + 1, value);
  }

  /// 累積して最終的な配列を構築し、参照を返す。複数回呼ぶと結果をキャッシュする。
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

  /// 構築済みの値を取得する。`build` を事前に呼ぶ必要がある。
  [[nodiscard]] const std::vector<T> &values() const {
    assert(ready);
    return built_values;
  }

  /// 構築済みの値へのランダムアクセス。`build` を事前に呼ぶ必要がある。
  [[nodiscard]] const T &operator[](usize idx) const {
    assert(ready);
    return built_values[idx];
  }

  /// 基底配列に差分を適用した新しい配列を返す。
  std::vector<T> applied(std::vector<T> base) {
    assert(base.size() == size());
    const auto &delta = build();
    for (usize i = 0; i < size(); ++i) {
      base[i] += delta[i];
    }
    return base;
  }
};

// ----- features/prime.hpp -----


/// エラトステネスの篩を用いた素数判定・素因数分解ユーティリティ。
class PrimeSieve {
private:
  int limit;
  std::vector<int> primes_vec;
  std::vector<int> least_prime;

  void build() {
    if (limit >= 0)
      least_prime[0] = 0;
    if (limit >= 1)
      least_prime[1] = 1;

    for (int i = 2; i <= limit; ++i) {
      if (least_prime[i] == 0) {
        least_prime[i] = i;
        primes_vec.push_back(i);
      }
      for (int p : primes_vec) {
        if (p > least_prime[i])
          break;
        ll mul = 1LL * i * p;
        if (mul > limit)
          break;
        least_prime[mul] = p;
      }
    }
  }

public:
  /// `n` 以下の整数を対象に篩を構築する。
  explicit PrimeSieve(int n) : limit(n), primes_vec(), least_prime(n + 1, 0) {
    assert(limit >= 0);
    build();
  }

  PrimeSieve(const PrimeSieve &) = delete;
  PrimeSieve &operator=(const PrimeSieve &) = delete;
  PrimeSieve(PrimeSieve &&) = default;
  PrimeSieve &operator=(PrimeSieve &&) = default;

  /// 篩の最大値（構築時の `n`）を返す。
  int max_n() const { return limit; }

  /// `n` 以下の素数リストを返す。
  const std::vector<int> &primes() const { return primes_vec; }

  /// `n` が素数か判定する。
  bool is_prime(int n) const {
    assert(0 <= n && n <= limit);
    return n >= 2 && least_prime[n] == n;
  }

  /// `n` の最小素因数を返す。
  int least_factor(int n) const {
    assert(1 <= n && n <= limit);
    return least_prime[n];
  }

  /// `n`（`n <= limit`）を素因数分解し、素因数と指数の組を返す。
  std::vector<std::pair<int, int>> factorize_bounded(int n) const {
    assert(1 <= n && n <= limit);
    std::vector<std::pair<int, int>> factors;
    while (n > 1) {
      int p = least_prime[n];
      int cnt = 0;
      while (n % p == 0) {
        n /= p;
        ++cnt;
      }
      factors.push_back({p, cnt});
    }
    return factors;
  }

  /// `n` を素因数分解する（`n <= limit^2` が前提）。
  std::vector<std::pair<ll, int>> factorize(ll n) const {
    assert(n >= 1);
    assert(1LL * limit * limit >= n);
    std::vector<std::pair<ll, int>> factors;
    ll cur = n;
    for (int p : primes_vec) {
      if (1LL * p * p > cur)
        break;
      if (cur % p != 0)
        continue;
      int cnt = 0;
      while (cur % p == 0) {
        cur /= p;
        ++cnt;
      }
      factors.push_back({p, cnt});
    }
    if (cur > 1) {
      factors.push_back({cur, 1});
    }
    return factors;
  }
};

// ----- features/tally.hpp -----


/// ベクタ内の要素頻度を `std::map` で数える。
template <typename T> std::map<T, u64> tally(const std::vector<T> &data) {
  std::map<T, u64> counts;
  for (const auto &item : data) {
    counts[item]++;
  }
  return counts;
}

// ----- features/cumulative_sum_2d.hpp -----


/// 2 次元配列の累積和を保持し、長方形領域の総和を O(1) で取得するクラス。
template <typename T> class CumulativeSum2D {
private:
  usize height;
  usize width;
  std::vector<std::vector<T>> prefix;

public:
  /// `grid` の累積和を構築する。行ごとの幅が一致していることを前提とする。
  explicit CumulativeSum2D(const std::vector<std::vector<T>> &grid)
      : height(grid.size()), width(height ? grid[0].size() : 0),
        prefix(height + 1, std::vector<T>(width + 1, 0)) {
    for (usize y = 0; y < height; ++y) {
      assert(grid[y].size() == width);
      for (usize x = 0; x < width; ++x) {
        prefix[y + 1][x + 1] =
            grid[y][x] + prefix[y][x + 1] + prefix[y + 1][x] - prefix[y][x];
      }
    }
  }

  /// 行数を返す。
  usize rows() const { return height; }

  /// 列数を返す。
  usize cols() const { return width; }

  /// 長方形 [top, bottom) × [left, right) の和を返す。
  T sum(usize top, usize left, usize bottom, usize right) const {
    assert(top <= bottom);
    assert(left <= right);
    assert(bottom <= height);
    assert(right <= width);
    return prefix[bottom][right] - prefix[top][right] - prefix[bottom][left] +
           prefix[top][left];
  }

  /// 長方形 [top, bottom] × [left, right] の和を返す。
  T sum_closed(usize top, usize left, usize bottom, usize right) const {
    assert(bottom < height);
    assert(right < width);
    return sum(top, left, bottom + 1, right + 1);
  }
};

// ----- features/imos_2d.hpp -----


/// 2 次元 Imos 法（差分配列）で長方形加算をまとめて反映するユーティリティ。
template <typename T> class Imos2D {
private:
  usize height;
  usize width;
  std::vector<std::vector<T>> diff;
  std::vector<std::vector<T>> built_values;
  bool ready;

public:
  /// 高さ `h`、幅 `w` の差分配列を初期化する。
  Imos2D(usize h, usize w)
      : height(h), width(w), diff(h + 1, std::vector<T>(w + 1, 0)),
        built_values(h, std::vector<T>(w, 0)), ready(false) {}

  /// 行数を返す。
  usize rows() const { return height; }

  /// 列数を返す。
  usize cols() const { return width; }

  /// 長方形 [top, bottom) × [left, right) に `value` を加算する。
  void add(usize top, usize left, usize bottom, usize right, const T &value) {
    assert(top <= bottom);
    assert(left <= right);
    assert(bottom <= height);
    assert(right <= width);
    diff[top][left] += value;
    diff[bottom][left] -= value;
    diff[top][right] -= value;
    diff[bottom][right] += value;
    ready = false;
  }

  /// 長方形 [top, bottom] × [left, right] に `value` を加算する。
  void add_closed(usize top, usize left, usize bottom, usize right,
                  const T &value) {
    assert(bottom < height);
    assert(right < width);
    add(top, left, bottom + 1, right + 1, value);
  }

  /// 累積して最終的な 2
  /// 次元配列を構築し、参照を返す。複数回呼ぶと結果をキャッシュする。
  [[nodiscard]] const std::vector<std::vector<T>> &build() {
    if (!ready) {
      std::vector<std::vector<T>> acc(height + 1, std::vector<T>(width + 1, 0));
      for (usize y = 0; y <= height; ++y) {
        for (usize x = 0; x <= width; ++x) {
          T val = diff[y][x];
          if (y > 0) {
            val += acc[y - 1][x];
          }
          if (x > 0) {
            val += acc[y][x - 1];
          }
          if (y > 0 && x > 0) {
            val -= acc[y - 1][x - 1];
          }
          acc[y][x] = val;
          if (y < height && x < width) {
            built_values[y][x] = val;
          }
        }
      }
      ready = true;
    }
    return built_values;
  }

  /// 構築済みの値を取得する。`build` を事前に呼ぶ必要がある。
  [[nodiscard]] const std::vector<std::vector<T>> &values() const {
    assert(ready);
    return built_values;
  }

  /// 構築済みの値への行アクセス。`build` を事前に呼ぶ必要がある。
  const std::vector<T> &operator[](usize row) const {
    assert(ready);
    return built_values[row];
  }

  /// 基底の 2 次元配列に差分を適用した新しい配列を返す。
  std::vector<std::vector<T>> applied(std::vector<std::vector<T>> base) {
    assert(base.size() == height);
    for (const auto &row : base) {
      assert(row.size() == width);
    }
    const auto &delta = build();
    for (usize y = 0; y < height; ++y) {
      for (usize x = 0; x < width; ++x) {
        base[y][x] += delta[y][x];
      }
    }
    return base;
  }
};

// ----- features/interval_set.hpp -----


/// 区間の和集合を `std::set` で管理するデータ構造。
template <typename T> class IntervalSet {
private:
  std::set<std::pair<T, T>> segs;

public:
  IntervalSet() = default;

  /// 現在保持している非交差の区間集合への参照を返す。
  const std::set<std::pair<T, T>> &intervals() const { return segs; }

  /// 点 `x` を含む区間を返す。存在しない場合は `std::nullopt`。
  std::optional<std::pair<T, T>> find(T x) const {
    auto it = segs.upper_bound({x, std::numeric_limits<T>::max()});
    if (it == segs.begin()) {
      return std::nullopt;
    }
    --it;
    if (it->first <= x && x < it->second) {
      return *it;
    }
    return std::nullopt;
  }

  /// 半開区間 `[l, r)` を追加し、新たに被覆された長さを返す。
  /// `l >= r` の場合は何もせず 0 を返す。
  T add(T l, T r) {
    if (l >= r) {
      return static_cast<T>(0);
    }

    T added = r - l;
    auto it = segs.lower_bound({l, l});
    if (it != segs.begin()) {
      auto prev = std::prev(it);
      if (prev->second >= l) {
        it = prev;
      }
    }

    std::vector<typename std::set<std::pair<T, T>>::iterator> erase_list;
    T nl = l;
    T nr = r;

    for (; it != segs.end() && it->first <= nr; ++it) {
      nl = std::min(nl, it->first);
      nr = std::max(nr, it->second);

      T left = std::max(l, it->first);
      T right = std::min(r, it->second);
      if (left < right) {
        added -= right - left;
      }
      erase_list.push_back(it);
    }

    for (auto e : erase_list) {
      segs.erase(e);
    }
    segs.emplace(nl, nr);
    return added;
  }

  /// 半開区間 `[l, r)` を削除し、減少した被覆長を返す。
  /// `l >= r` の場合は何もせず 0 を返す。
  T remove(T l, T r) {
    if (l >= r) {
      return static_cast<T>(0);
    }

    auto it = segs.lower_bound({l, l});
    if (it != segs.begin()) {
      auto prev = std::prev(it);
      if (prev->second > l) {
        it = prev;
      }
    }

    std::vector<std::pair<T, T>> add_back;
    std::vector<typename std::set<std::pair<T, T>>::iterator> erase_list;
    T removed = 0;

    for (; it != segs.end() && it->first < r; ++it) {
      auto [il, ir] = *it;
      if (ir <= l) {
        continue;
      }

      T left = std::max(l, il);
      T right = std::min(r, ir);
      if (left >= right) {
        continue;
      }

      removed += right - left;
      if (il < left) {
        add_back.emplace_back(il, left);
      }
      if (right < ir) {
        add_back.emplace_back(right, ir);
      }
      erase_list.push_back(it);
    }

    for (auto e : erase_list) {
      segs.erase(e);
    }
    for (auto [il, ir] : add_back) {
      segs.emplace(il, ir);
    }
    return removed;
  }
};

// ----- features/vec_map.hpp -----


/// コンテナ内の要素に対してFを適用したものを返す。
template <typename T, typename F, typename V>
std::vector<T> vec_map(const V &vec, F &&func) {
  std::vector<T> result;
  result.reserve(sz(vec));
  each(x, vec) { result.push_back(func(x)); }
  return result;
}

/// コンテナ内の要素をFによって変換する。
template <typename F, typename V> void vec_map_inplace(V &vec, F &&func) {
  each(x, vec) { x = func(x); }
}

// ----- main.cpp -----

fn main() -> int {
  cin.tie(0)->sync_with_stdio(0);
  cout << fixed << setprecision(15);

  // your code here...
}
