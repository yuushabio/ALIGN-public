#pragma once

#include <nlohmann/json.hpp>
#include <spdlog/fmt/fmt.h>
#include <string>

#include "../PnRDB/datatype.h"
#include "../placer/Pdatatype.h"
#include "../MNA/Mdatatype.h"
#include "../router/Rdatatype.h"

template <>
struct fmt::formatter<nlohmann::json> {
  constexpr auto parse(fmt::format_parse_context& ctx) { return ctx.begin(); }

  template <typename FormatContext>
  auto format(const nlohmann::json& j, FormatContext& ctx) const {
    return fmt::format_to(ctx.out(), "{}", j.dump());
  }
};

#define ALIGN_FMT_ENUM(EnumType)                                      \
  template <>                                                         \
  struct fmt::formatter<EnumType> {                                   \
    constexpr auto parse(fmt::format_parse_context& ctx) {          \
      return ctx.begin();                                             \
    }                                                                 \
    template <typename FormatContext>                                 \
    auto format(EnumType value, FormatContext& ctx) const {           \
      return fmt::format_to(ctx.out(), "{}", static_cast<int>(value)); \
    }                                                                 \
  };

ALIGN_FMT_ENUM(PnRDB::NType)
ALIGN_FMT_ENUM(PnRDB::Omark)
ALIGN_FMT_ENUM(PnRDB::Smark)
ALIGN_FMT_ENUM(PnRDB::Bmark)
ALIGN_FMT_ENUM(PnRDB::TransformType)
ALIGN_FMT_ENUM(placerDB::NType)
ALIGN_FMT_ENUM(placerDB::Omark)
ALIGN_FMT_ENUM(placerDB::Smark)
ALIGN_FMT_ENUM(placerDB::Bmark)
ALIGN_FMT_ENUM(MDB::Element)
ALIGN_FMT_ENUM(RouterDB::NType)
ALIGN_FMT_ENUM(RouterDB::Omark)
ALIGN_FMT_ENUM(RouterDB::SType)

#undef ALIGN_FMT_ENUM
