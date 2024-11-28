module ApplicationHelper

  def tailwind_pagination_theme
    {
      'nav': '',
      'ul': 'relative z-0 inline-flex rounded-md shadow-sm -space-x-px',
      'li': '',
      'a': 'relative inline-flex items-center px-4 py-2 border text-sm font-medium',
      'current': 'z-10 bg-blue-50 border-blue-500 text-blue-600',
      'previous': 'relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50',
      'next': 'relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50',
      'gap': 'relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700'
    }
  end

end
