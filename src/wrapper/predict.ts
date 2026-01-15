import type { CartItem, Logic as _Logic, Filter as _Filter } from './NativeEmarsysPredict';

export const Logic = {
  search: (searchTerm?: string | null) =>
    <_Logic>{ name: 'SEARCH', query: searchTerm },
  cart: (items?: CartItem[] | null) =>
    <_Logic>{ name: 'CART', cartItems: items },
  related: (itemId?: string | null) =>
    <_Logic>{ name: 'RELATED', query: itemId },
  category: (categoryPath?: string | null) =>
    <_Logic>{ name: 'CATEGORY', query: categoryPath },
  alsoBought: (itemId?: string | null) =>
    <_Logic>{ name: 'ALSO_BOUGHT', query: itemId },
  popular: (categoryPath?: string | null) =>
    <_Logic>{ name: 'POPULAR', query: categoryPath },
  personal: (variants?: string[] | null) =>
    <_Logic>{ name: 'PERSONAL', variants: variants },
  home: (variants?: string[] | null) =>
    <_Logic>{ name: 'HOME', variants: variants }
};

export const Filter = {
  include: {
    isValue: (field: string, value: string) =>
      <_Filter>{ type: 'INCLUDE', field, comparison: 'IS', expectations: [value] },
    inValues: (field: string, values: string[]) =>
      <_Filter>{ type: 'INCLUDE', field, comparison: 'IN', expectations: values },
    hasValue: (field: string, value: string) =>
      <_Filter>{ type: 'INCLUDE', field, comparison: 'HAS', expectations: [value] },
    overlapsValues: (field: string, values: string[]) =>
      <_Filter>{ type: 'INCLUDE', field, comparison: 'OVERLAPS', expectations: values }
  },
  exclude: {
    isValue: (field: string, value: string) =>
      <_Filter>{ type: 'EXCLUDE', field, comparison: 'IS', expectations: [value] },
    inValues: (field: string, values: string[]) =>
      <_Filter>{ type: 'EXCLUDE', field, comparison: 'IN', expectations: values },
    hasValue: (field: string, value: string) =>
      <_Filter>{ type: 'EXCLUDE', field, comparison: 'HAS', expectations: [value] },
    overlapsValues: (field: string, values: string[]) =>
      <_Filter>{ type: 'EXCLUDE', field, comparison: 'OVERLAPS', expectations: values }
  }
};
