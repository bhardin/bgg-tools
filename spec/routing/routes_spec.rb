require 'spec_helper'

describe 'Routes' do
  describe '/users' do
    it 'routes when the username has periods' do
      expect(get: '/users/alfred.e.newman').to route_to(
        action: 'show',
        controller: 'users',
        id: 'alfred.e.newman'
      )
    end
  end
end
