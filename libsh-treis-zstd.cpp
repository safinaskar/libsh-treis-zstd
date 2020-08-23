// 2018DECTMP

//@ #pragma once

#include "libsh-treis/libsh-treis.hpp"
#include "libsh-treis-zstd.hpp"

//@ #include <span>
//@ #include <cstddef>
#include <zstd.h>
namespace libsh_treis::zstd //@
{ //@
std::span<std::byte> //@
x_compress (std::span<std::byte> dst, std::span<const std::byte> src, int compressionLevel)//@;
{
  std::size_t result = ZSTD_compress (dst.data (), dst.size (), src.data (), src.size (), compressionLevel);

  if (ZSTD_isError (result))
    {
      _LIBSH_TREIS_THROW_MESSAGE (ZSTD_getErrorName (result));
    }

  return std::span<std::byte> (dst.data (), result);
}
} //@

//@ #include <span>
//@ #include <cstddef>
#include <zstd.h>
namespace libsh_treis::zstd //@
{ //@
std::span<std::byte> //@
x_decompress (std::span<std::byte> dst, std::span<const std::byte> src)//@;
{
  std::size_t result = ZSTD_decompress (dst.data (), dst.size (), src.data (), src.size ());

  if (ZSTD_isError (result))
    {
      _LIBSH_TREIS_THROW_MESSAGE (ZSTD_getErrorName (result));
    }

  return std::span<std::byte> (dst.data (), result);
}
} //@
